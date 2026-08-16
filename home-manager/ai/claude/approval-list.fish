#!/etc/profiles/per-user/nixos/bin/fish

if not test -s /tmp/claude-approvals
    tmux display-message "No pending approvals"
    exit 0
end

set -l lines (cat /tmp/claude-approvals)
set -l selected (printf '%s\n' $lines | gum choose --header "⚡ Pending approvals — select to jump" --padding "0 1")

if test -n "$selected"
    set -l index (contains -i -- "$selected" $lines)
    printf '%s\n' $lines | sed "$index"d > /tmp/claude-approvals.tmp
    mv /tmp/claude-approvals.tmp /tmp/claude-approvals

    set -l parts (string split ':' $selected)
    tmux switch-client -t "$parts[1]:$parts[2]"
end
