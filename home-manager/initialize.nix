{
  pkgs,
  miko,
  ...
}:
let
  initialize = pkgs.writeShellApplication {
    name = "initialize";

    text = ''
      # No marker is a source of truth — the probes are. Both kinds expire together, so
      # an answer and a probe result each re-derive themselves at most a day later.
      TTL_MINUTES=1440

      # Usage: marker_fresh ok|declined TOOL
      marker_fresh() {
          marker="/tmp/initialize-$1-$2"

          [ -f "$marker" ] || return 1

          if [ -n "$(${pkgs.findutils}/bin/find "$marker" -mmin "+$TTL_MINUTES" 2>/dev/null)" ]; then
              rm -f "$marker"
              return 1
          fi

          return 0
      }

      # Usage: mark ok|declined TOOL
      mark() {
          : > "/tmp/initialize-$1-$2"
      }

      # Usage: probe TOOL
      # Prints "configured", "not-configured", or "unknown:<reason>". A probe that
      # cannot tell says so rather than falling back to "configured", which would
      # silently suppress the very question the probe exists to ask.
      probe() {
          case "$1" in
              tide)
                  # Only `tide configure` writes tide_left_prompt_items. The lean
                  # defaults that would also write it are loaded from fisher's
                  # _tide_init_install event, which home-manager never emits — so
                  # installing tide through fisher would silently make this probe
                  # answer "configured" forever.
                  if ${pkgs.fish}/bin/fish -c 'set -q tide_left_prompt_items'; then
                      echo configured
                  else
                      echo not-configured
                  fi
                  ;;

              gh)
                  # `gh auth status`, not `gh status`: the latter is the activity
                  # dashboard, which writes to stderr even when signed in and costs a
                  # network round trip.
                  if ${pkgs.gh}/bin/gh auth status >/dev/null 2>&1; then
                      echo configured
                  else
                      echo not-configured
                  fi
                  ;;

              tailscale)
                  # stderr carries a client/server version warning, so only stdout may
                  # reach jq.
                  state=$(${pkgs.tailscale}/bin/tailscale status --json 2>/dev/null \
                      | ${pkgs.jq}/bin/jq -r '.BackendState // empty') || state=""

                  case "$state" in
                      NeedsLogin) echo not-configured ;;
                      Running | Stopped | Starting | NeedsMachineAuth) echo configured ;;
                      "") echo "unknown:tailscale reported no BackendState" ;;
                      *) echo "unknown:tailscale reported BackendState $state" ;;
                  esac
                  ;;

              ntn)
                  if ${pkgs.ntn}/bin/ntn whoami >/dev/null 2>&1; then
                      echo configured
                  else
                      echo not-configured
                  fi
                  ;;
          esac
      }

      # Usage: question TOOL
      question() {
          case "$1" in
              tide) echo "Do you want to configure the Tide prompt?" ;;
              gh) echo "Do you want to log in to the GitHub CLI?" ;;
              tailscale) echo "Do you want to log in to Tailscale as root?" ;;
              ntn) echo "Do you want to log in to the Notion CLI?" ;;
          esac
      }

      # Usage: run_setup TOOL
      run_setup() {
          case "$1" in
              tide) ${pkgs.fish}/bin/fish -c "tide configure" ;;
              gh) ${pkgs.gh}/bin/gh auth login ;;
              ntn) ${pkgs.ntn}/bin/ntn login ;;

              tailscale)
                  login_args=()

                  # `|| echo ""` keeps a cancelled prompt from tripping errexit.
                  ts_hostname=$(${pkgs.gum}/bin/gum input --header "Hostname" \
                      --placeholder "leave empty to let Tailscale generate one" || echo "")

                  if [ -n "$ts_hostname" ]; then
                      login_args+=("--hostname=$ts_hostname")
                  fi

                  if ${pkgs.gum}/bin/gum confirm --default=false \
                      "Run an SSH server, permitting access per the tailnet admin's policy?"; then
                      login_args+=("--ssh")
                  fi

                  if ${pkgs.gum}/bin/gum confirm --default=false \
                      "Offer to be an exit node for internet traffic for the tailnet?"; then
                      login_args+=("--advertise-exit-node")
                  fi

                  sudo ${pkgs.tailscale}/bin/tailscale login "''${login_args[@]}"
                  ;;
          esac
      }

      for tool in tide gh tailscale ntn; do
          if marker_fresh ok "$tool" || marker_fresh declined "$tool"; then
              continue
          fi

          result=$(probe "$tool")

          if [ "$result" = configured ]; then
              mark ok "$tool"
              continue
          fi

          if [ "$result" != not-configured ]; then
              echo "initialize: ''${result#unknown:}; asking about $tool anyway" >&2
          fi

          # `|| echo Skip` keeps a cancelled picker from tripping errexit.
          choice=$(${pkgs.gum}/bin/gum choose Yes No Skip \
              --header "$(question "$tool")" --padding "0 1" || echo Skip)

          case "$choice" in
              Yes)
                  if run_setup "$tool"; then
                      mark ok "$tool"
                  fi
                  ;;

              No) mark declined "$tool" ;;

              *) ;;
          esac
      done
    '';
  };
in
{
  home = {
    file = miko.getDocs [
      {
        filePath = "initialize";
        docs = ''
          # initialize

          Ask about each tool this machine expects to be set up, and run its login or
          configure command.

          [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/initialize.nix)

          ## Gotcha

          - It runs on every interactive fish shell, and each tool is probed live, so
            logging out of `gh` or `tailscale` brings its question back.
          - Answering `No` lasts 24 hours and is kept in `/tmp`. A tool declined because
            it was broken is asked about again the next day rather than never.
        '';
      }
    ];

    packages = [ initialize ];
  };

  programs.fish.interactiveShellInit = ''
    # initialize
    if type -q initialize
      initialize
    end
  '';
}
