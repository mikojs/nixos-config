{
  ...
}:
{
  fish-alias = ''
    - `tm`: Run a command in a tmux session, creating or attaching to it as needed.
    - `tmls`: Show tmux panes.
  '';

  programs.interactiveShellInit = ''
    function tm --description "tm <command> [-s session_name] — run a command in a tmux session"
      argparse 's/session=' -- $argv
      or return 1

      if test (count $argv) -eq 0
        echo "❌ Error: Please provide a command to run!"
        echo "Usage: tm <command> [-s session_name]"
        return 1
      end

      if set -q _flag_session
        if set -q TMUX
          if test "$_flag_session" = (tmux display-message -p '#{session_name}')
            echo "⚡ Already inside [$_flag_session]. Executing command directly..."
            eval $argv
          else
            if tmux has-session -t $_flag_session 2>/dev/null
              echo "🔄 Switching to existing session [$_flag_session] and creating new window..."
              tmux new-window -t $_flag_session "$argv; exec $SHELL"
            else
              echo "🆕 Session [$_flag_session] not found. Creating it automatically..."
              tmux new-session -d -s $_flag_session "$argv; exec $SHELL"
            end

            tmux switch-client -t $_flag_session
          end
        else
          if tmux has-session -t $_flag_session 2>/dev/null
            echo "🔄 Session [$_flag_session] exists. Creating new window and attaching..."
            tmux new-window -t $_flag_session "$argv; exec $SHELL"
            tmux attach-session -t $_flag_session
          else
            echo "🆕 Session [$_flag_session] not found. Creating and attaching..."
            tmux new-session -s $_flag_session "$argv; exec $SHELL"
          end
        end

      else
        if set -q TMUX
          echo "⚡ Inside tmux. Executing command directly..."
          eval $argv
        else
          set -l git_root (git rev-parse --show-toplevel 2>/dev/null)

          if test -n "$git_root"
            set -l git_session (basename $git_root)
            echo "🆕 Git repo detected. Using session [$git_session]..."

            if tmux has-session -t $git_session 2>/dev/null
              tmux new-window -t $git_session "$argv; exec $SHELL"
              tmux attach-session -t $git_session
            else
              tmux new-session -s $git_session "$argv; exec $SHELL"
            end
          else
            echo "🆕 Creating a new default tmux session and executing..."
            tmux new-session "$argv; exec $SHELL"
          end
        end
      end
    end

    function tmls --description "tmls — show tmux panes"
      begin
        echo -e "session,pane,command"
        tmux list-panes -a -F "#{session_name},#{window_index}.#{pane_index},#{pane_current_command}"
      end | column -t -s ','
    end
  '';
}
