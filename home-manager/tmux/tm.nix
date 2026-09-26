{
  pkgs,
  miko,
  ...
}:
{
  home.file = miko.getDocs [
    {
      filePath = "tmux/tm";
      docs = ''
        # tm

        Run a command in a tmux session, creating or attaching to it as needed.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/tmux/tm.nix)

        ```sh
        tm <command> [...]                # attach to a session for the current git repo (or default)
        tm <command> [...] -s <session>   # attach to a named session
        ```
      '';
    }
    {
      filePath = "tmux/tmls";
      docs = ''
        # tmls

        Show tmux panes across all sessions.

        [Code](https://github.com/mikojs/nixos-config/tree/main/home-manager/tmux/tm.nix)

        ```sh
        tmls
        ```
      '';
    }
  ];

  home.packages = [
    (pkgs.writeShellApplication {
      name = "tm";

      text = ''
        session=""
        args=()

        while [[ $# -gt 0 ]]; do
          case "$1" in
            -s|--session)
              session="$2"
              shift 2
              ;;
            --session=*)
              session="''${1#--session=}"
              shift
              ;;
            *)
              args+=("$1")
              shift
              ;;
          esac
        done

        set -- "''${args[@]}"

        if [[ $# -eq 0 ]]; then
          echo "❌ Error: Please provide a command to run!"
          echo "Usage: tm <command> [-s session_name]"
          exit 1
        fi

        if [[ -n "$session" ]]; then
          if [[ -n "''${TMUX:-}" ]]; then
            if [[ "$session" == "$(${pkgs.tmux}/bin/tmux display-message -p '#{session_name}')" ]]; then
              echo "⚡ Already inside [$session]. Executing command directly..."
              eval "$*"
            else
              if ${pkgs.tmux}/bin/tmux has-session -t "$session" 2>/dev/null; then
                echo "🔄 Switching to existing session [$session] and creating new window..."
                ${pkgs.tmux}/bin/tmux new-window -t "$session" "$*; exec $SHELL"
              else
                echo "🆕 Session [$session] not found. Creating it automatically..."
                ${pkgs.tmux}/bin/tmux new-session -d -s "$session" "$*; exec $SHELL"
              fi

              ${pkgs.tmux}/bin/tmux switch-client -t "$session"
            fi
          else
            if ${pkgs.tmux}/bin/tmux has-session -t "$session" 2>/dev/null; then
              echo "🔄 Session [$session] exists. Creating new window and attaching..."
              ${pkgs.tmux}/bin/tmux new-window -t "$session" "$*; exec $SHELL"
              ${pkgs.tmux}/bin/tmux attach-session -t "$session"
            else
              echo "🆕 Session [$session] not found. Creating and attaching..."
              ${pkgs.tmux}/bin/tmux new-session -s "$session" "$*; exec $SHELL"
            fi
          fi
        else
          if [[ -n "''${TMUX:-}" ]]; then
            echo "⚡ Inside tmux. Executing command directly..."
            eval "$*"
          else
            git_root="$(${pkgs.git}/bin/git rev-parse --show-toplevel 2>/dev/null || true)"

            if [[ -n "$git_root" ]]; then
              git_session="$(basename "$git_root")"
              echo "🆕 Git repo detected. Using session [$git_session]..."

              if ${pkgs.tmux}/bin/tmux has-session -t "$git_session" 2>/dev/null; then
                ${pkgs.tmux}/bin/tmux new-window -t "$git_session" "$*; exec $SHELL"
                ${pkgs.tmux}/bin/tmux attach-session -t "$git_session"
              else
                ${pkgs.tmux}/bin/tmux new-session -s "$git_session" "$*; exec $SHELL"
              fi
            else
              echo "🆕 Creating a new default tmux session and executing..."
              ${pkgs.tmux}/bin/tmux new-session "$*; exec $SHELL"
            fi
          fi
        fi
      '';
    })

    (pkgs.writeShellApplication {
      name = "tmls";

      text = ''
        {
          echo "session,pane,command"
          ${pkgs.tmux}/bin/tmux list-panes -a -F "#{session_name},#{window_index}.#{pane_index},#{pane_current_command}"
        } | column -t -s ','
      '';
    })
  ];
}
