{ pkgs }:
pkgs.writeShellApplication {
  name = "claude-approval-list";

  text = ''
    # why: claude clears O_NONBLOCK on the shared popup tty, deadlocking tmux
    agents() {
        ${pkgs.claude-code}/bin/claude agents --json </dev/null 2>/dev/null
    }

    status_of() {
        agents | ${pkgs.jq}/bin/jq -r --argjson p "$1" '.[] | select(.pid == $p) | .status'
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

    tmp="approve-$$"
    watcher=""

    cleanup() {
        if [ -n "$watcher" ]; then
            kill "$watcher" 2>/dev/null || :
        fi

        ${pkgs.tmux}/bin/tmux kill-session -t "$tmp" 2>/dev/null || :
    }
    trap cleanup EXIT

    # Return to the list after each answer; close once nothing is waiting.
    first=1
    while true; do
        entries=()

        while read -r pid name; do
            read -r session window pane wname <<< "$(pane_of "$pid")" || continue
            [ -n "''${pane:-}" ] || continue
            entries+=("$session:$window:$wname  ($name)  pid=$pid pane=$pane")
        done < <(agents | ${pkgs.jq}/bin/jq -r '.[] | select(.status == "waiting") | "\(.pid) \(.name)"')

        if [ ''${#entries[@]} -eq 0 ]; then
            if [ "$first" = 1 ]; then
                echo "No agents waiting"
                ${pkgs.coreutils}/bin/sleep 1
            fi

            exit 0
        fi

        first=0

        # `|| :` keeps a cancelled picker (gum exits non-zero) from tripping errexit.
        selected=$(printf '%s\n' "''${entries[@]}" |
            ${pkgs.gum}/bin/gum choose --header "⚡ Waiting agents — select to answer" --padding "0 1" || :)
        [ -n "$selected" ] || exit 0

        pid=''${selected##*pid=}
        pid=''${pid%% *}
        pane=''${selected##*pane=}
        target=''${selected%%  (*}
        session=''${target%%:*}
        window=''${target#*:}
        window=''${window%%:*}

        # why: a session holding only the agent's window leaves nothing to switch to
        ${pkgs.tmux}/bin/tmux new-session -d -s "$tmp"
        ${pkgs.tmux}/bin/tmux link-window -k -s "$session:$window" -t "$tmp:0"
        ${pkgs.tmux}/bin/tmux select-pane -t "$pane"

        # Detach from the agent once it stops waiting.
        (
            while [ "$(status_of "$pid")" = "waiting" ]; do
                ${pkgs.coreutils}/bin/sleep 1
            done

            ${pkgs.tmux}/bin/tmux kill-session -t "$tmp" 2>/dev/null || :
        ) &
        watcher=$!

        TMUX=''' ${pkgs.tmux}/bin/tmux attach-session -t "$tmp" || :
        cleanup
        watcher=""
    done
  '';
}
