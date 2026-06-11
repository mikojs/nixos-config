{
  name,
  ...
}:
{
  pkgs,
  miko,
  isMac,
  ...
}:
{
  home.file = miko.getDocs [
    {
      filePath = "tmux";
      docs = ''
        # Tmux

        Tmux is a terminal multiplexer.

        [Repository](https://github.com/tmux/tmux)
      '';
    }
  ];

  programs = {
    tmux = {
      enable = true;

      plugins = with pkgs.tmuxPlugins; [
        nord
      ];

      # FIXME: default shell, https://github.com/nix-darwin/nix-darwin/issues/1237
      extraConfig =
        if !isMac then "" else "set-option -g default-command /etc/profiles/per-user/${name}/bin/fish";
    };

    fish.interactiveShellInit = ''
      if not set -q LANG
        set -Ux LANG en_US.UTF-8
      end

      # Run a command in tmux
      function tm --description "tm <command> [-s session_name]"
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
                echo "🔄 Switching to existing session [$_flag_session] and splitting pane..."
                tmux split-window -t $_flag_session -h "$argv; exec $SHELL"
              else
                echo "🆕 Session [$_flag_session] not found. Creating it automatically..."
                tmux new-session -d -s $_flag_session "$argv; exec $SHELL"
              end

              tmux switch-client -t $_flag_session
            end
          else
            if tmux has-session -t $_flag_session 2>/dev/null
              echo "🔄 Session [$_flag_session] exists. Splitting pane and attaching..."
              tmux split-window -t $_flag_session -h "$argv; exec $SHELL"
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
            echo "🆕 Creating a new default tmux session and executing..."
            tmux new-session "$argv; exec $SHELL"
          end
        end
      end

      # Show tmux panes
      function tmls --description "Show tmux panes"
        begin
          echo -e "session,pane,command"
          tmux list-panes -a -F "#{session_name},#{window_index}.#{pane_index},#{pane_current_command}"
        end | column -t -s ','
      end
    '';
  };
}
