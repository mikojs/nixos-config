{ pkgs }:
pkgs.writeShellApplication {
  name = "claude-approval-hook";

  text = ''
    if [ -z "''${TMUX:-}" ]; then
        exit 0
    fi

    # Nothing to announce when the user is already looking at this pane.
    if [ "$(${pkgs.tmux}/bin/tmux display-message -t "$TMUX_PANE" -p '#{window_active}')" = "1" ] &&
       [ "$(${pkgs.tmux}/bin/tmux display-message -t "$TMUX_PANE" -p '#{session_attached}')" != "0" ]; then
        exit 0
    fi

    location=$(${pkgs.tmux}/bin/tmux display-message -t "$TMUX_PANE" -p '#{session_name}:#{window_index}:#{window_name}')

    echo "$location" >> /tmp/claude-approvals

    ${pkgs.tmux}/bin/tmux list-clients -F '#{client_name}' | while IFS= read -r client; do
        ${pkgs.tmux}/bin/tmux display-message -c "$client" -d 5000 "⚡ Agent needs approval: $location"
    done
  '';
}
