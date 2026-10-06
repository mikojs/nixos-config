{ pkgs }:
pkgs.writeShellApplication {
  name = "claude-approval-list";

  text = ''
    agents() {
        ${pkgs.claude-code}/bin/claude agents --json
    }

    # Walk up from the claude pid to the shell tmux started for the pane.
    pane_of() {
        local pid=$1 hit

        while [ "$pid" -gt 1 ]; do
            hit=$(${pkgs.tmux}/bin/tmux list-panes -a -F '#{pane_pid} #{session_name} #{window_index} #{pane_id} #{window_name}' |
                ${pkgs.gawk}/bin/awk -v p="$pid" '$1 == p { print $2, $3, $4, $5; exit }')

            if [ -n "$hit" ]; then
                echo "$hit"
                return
            fi

            pid=$(${pkgs.procps}/bin/ps -o ppid= -p "$pid" | ${pkgs.coreutils}/bin/tr -d ' ')
        done
    }

    entries=()

    while read -r pid name; do
        read -r session window pane wname <<< "$(pane_of "$pid")" || continue
        [ -n "''${pane:-}" ] || continue
        entries+=("$session:$window:$wname  ($name)  pid=$pid pane=$pane")
    done < <(agents | ${pkgs.jq}/bin/jq -r '.[] | select(.status == "waiting") | "\(.pid) \(.name)"')

    if [ ''${#entries[@]} -eq 0 ]; then
        echo "No agents waiting"
        ${pkgs.coreutils}/bin/sleep 1
        exit 0
    fi

    # `|| :` keeps a cancelled picker (gum exits non-zero) from tripping errexit.
    selected=$(printf '%s\n' "''${entries[@]}" |
        ${pkgs.gum}/bin/gum choose --header "⚡ Waiting agents — select to answer" --padding "0 1" || :)
    [ -n "$selected" ] || exit 0

    # Switch the popup's client instead of attaching from inside the popup:
    # a nested attach to the same server deadlocks it.
    ${pkgs.tmux}/bin/tmux switch-client -t "''${selected##*pane=}"
  '';
}
