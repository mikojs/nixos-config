#!/etc/profiles/per-user/nixos/bin/fish

if not set -q TMUX
    exit 0
end

if test (tmux display-message -t $TMUX_PANE -p '#{window_active}') = "1"
    and test (tmux display-message -t $TMUX_PANE -p '#{session_attached}') != "0"
    exit 0
end

set -l location (tmux display-message -t $TMUX_PANE -p '#{session_name}:#{window_index}:#{window_name}')

echo $location >> /tmp/claude-approvals

for client in (tmux list-clients -F '#{client_name}')
    tmux display-message -c $client -d 5000 "⚡ Agent needs approval: $location"
end
