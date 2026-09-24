{
  pkgs,
  miko,
  ...
}:
let
  checkCommandStr = command: ''
    if [[ "''${1:-}" != *@* ]]; then
      echo "${command}: usage: ${command} <username>@<hostname> [...argv]" >&2
      exit 2
    fi
  '';
in
{
  home.file = miko.getDocs [
    {
      filePath = "tssh";
      docs = ''
        # tssh

        SSH into a Tailscale node.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/tailscale.nix)

        ```sh
        tssh <user>@<host>                        # interactive shell
        tssh <user>@<host> forward <port> [...]   # forward ports to local
        tssh <user>@<host> exec <cmd> [...]       # run commands remotely
        ```
      '';
    }
    {
      filePath = "tdocker";
      docs = ''
        # tdocker

        Run Docker against a remote Tailscale node via an SSH context.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/tailscale.nix)

        ```sh
        tdocker <user>@<host> <docker args...>
        ```

        Creates a Docker context for the host on first use.
      '';
    }
    {
      filePath = "tcoder";
      docs = ''
        # tcoder

        Sync a git repository to/from a remote Tailscale node using `miko-coder`.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/tailscale.nix)

        ```sh
        tcoder <user>@<host> push <dir>
        tcoder <user>@<host> pull <dir>
        ```
      '';
    }
  ];

  home.packages = [
    (pkgs.writeShellScriptBin "tssh" ''
      set -euo pipefail

      ${checkCommandStr "tssh"}
      user="''${1%%@*}"
      host="''${1#*@}"

      case "''${2:-}" in
        forward)
          ports=()

          for port in "''${@:3}"; do
            ports+=("-L" "$port:localhost:$port")
          done

          exec ${pkgs.openssh}/bin/ssh "$user@$(${pkgs.tailscale}/bin/tailscale ip -4 "$host")" "''${ports[@]}" -t fish
          ;;

        exec)
          printf -v commands '%s; ' "''${@:3}"
          commands="''${commands%; }"
          ${pkgs.openssh}/bin/ssh "$user@$(${pkgs.tailscale}/bin/tailscale ip -4 "$host")" "fish -c \"$commands\""
          ;;

        *)
          exec ${pkgs.openssh}/bin/ssh "$user@$(${pkgs.tailscale}/bin/tailscale ip -4 "$host")" -t fish
          ;;
      esac
    '')

    (pkgs.writeShellScriptBin "tdocker" ''
      set -euo pipefail

      ${checkCommandStr "tdocker"}
      user="''${1%%@*}"
      host="''${1#*@}"

      if ! ${pkgs.docker}/bin/docker context ls -q | ${pkgs.gnugrep}/bin/grep -q "$host"; then
        ${pkgs.docker}/bin/docker context create "$host" --docker "host=ssh://$user@$(${pkgs.tailscale}/bin/tailscale ip -4 "$host")"
      fi

      exec ${pkgs.docker}/bin/docker -c "$host" "''${@:2}"
    '')

    (pkgs.writeShellScriptBin "tcoder" ''
      set -euo pipefail

      ${checkCommandStr "tcoder"}
      if [[ "''${2:-}" != "push" && "''${2:-}" != "pull" ]]; then
        echo "tcoder: usage: tcoder <username>@<hostname> <push|pull> <directory>" >&2
        exit 2
      fi

      user="''${1%%@*}"
      host="''${1#*@}"

      exec ${pkgs.miko-coder}/bin/coder "$2" "ssh://$user@$(${pkgs.tailscale}/bin/tailscale ip -4 "$host")" "$3"
    '')
  ];
}
