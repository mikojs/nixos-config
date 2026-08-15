#!/etc/profiles/per-user/nixos/bin/fish

if not test -s /tmp/claude-approvals
    gum style --border rounded --padding "1 2" "No pending approvals"
    sleep 2
    exit 0
end

set -l selected (cat /tmp/claude-approvals | gum choose --header "⚡ Pending approvals — select to jump")

if test -n "$selected"
    grep -v "^$selected\$" /tmp/claude-approvals > /tmp/claude-approvals.tmp
    mv /tmp/claude-approvals.tmp /tmp/claude-approvals

    set -l parts (string split ':' $selected)
    tmux switch-client -t "$parts[1]:$parts[2]"
end
