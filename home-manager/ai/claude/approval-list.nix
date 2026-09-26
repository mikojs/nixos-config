{ pkgs }:
pkgs.writeShellApplication {
  name = "claude-approval-list";

  text = ''
    if [ ! -s /tmp/claude-approvals ]; then
        ${pkgs.tmux}/bin/tmux display-message "No pending approvals"
        exit 0
    fi

    mapfile -t lines < /tmp/claude-approvals

    # `|| :` keeps a cancelled picker (gum exits non-zero) from tripping errexit.
    selected=$(printf '%s\n' "''${lines[@]}" \
        | ${pkgs.gum}/bin/gum choose --header "⚡ Pending approvals — select to jump" --padding "0 1" || :)

    if [ -n "$selected" ]; then
        # Drop only the first match, so duplicate entries survive one jump each.
        for i in "''${!lines[@]}"; do
            if [ "''${lines[$i]}" = "$selected" ]; then
                printf '%s\n' "''${lines[@]}" \
                    | ${pkgs.gnused}/bin/sed "$((i + 1))d" > /tmp/claude-approvals.tmp
                ${pkgs.coreutils}/bin/mv /tmp/claude-approvals.tmp /tmp/claude-approvals
                break
            fi
        done

        IFS=: read -r session window _ <<< "$selected"
        ${pkgs.tmux}/bin/tmux switch-client -t "$session:$window"
    fi
  '';
}
