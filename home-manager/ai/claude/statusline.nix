{ pkgs }:
pkgs.writeShellApplication {
  name = "claude-statusline";

  text = ''
    input=$(${pkgs.coreutils}/bin/cat)

    # Fall back to an empty object on unparseable input, so every field below
    # still reaches its jq default instead of coming back blank.
    printf '%s' "$input" | ${pkgs.jq}/bin/jq -e . >/dev/null 2>&1 || input='{}'

    # --- Colors ---
    esc=$(printf '\033')
    NORMAL="''${esc}[0m"
    BLUE="''${esc}[34m"
    CYAN="''${esc}[36m"
    GREEN="''${esc}[32m"
    YELLOW="''${esc}[33m"
    RED="''${esc}[31m"
    BRBLACK="''${esc}[90m"

    # --- Parse all fields ---
    # Numbers are floored here so the shell only ever does integer arithmetic.
    # `|| :` keeps a short read from tripping errexit: an empty trailing field
    # is dropped by the command substitution, so the last read can hit EOF.
    {
        IFS= read -r MODEL || :
        IFS= read -r VERSION || :
        IFS= read -r DIR || :
        IFS= read -r DURATION_MS || :
        IFS= read -r LINES_ADD || :
        IFS= read -r LINES_DEL || :
        IFS= read -r PCT_CTX || :
        IFS= read -r PCT_5H || :
        IFS= read -r PCT_7D || :
        IFS= read -r BRANCH || :
    } <<EOF
    $(printf '%s' "$input" | ${pkgs.jq}/bin/jq -r '
        (.model.display_name // "unknown"),
        (.version // ""),
        (.workspace.current_dir // "."),
        ((.cost.total_duration_ms // 0) | floor),
        ((.cost.total_lines_added // 0) | floor),
        ((.cost.total_lines_removed // 0) | floor),
        ((.context_window.used_percentage // 0) | floor),
        ((.rate_limits.five_hour.used_percentage // 0) | floor),
        ((.rate_limits.seven_day.used_percentage // 0) | floor),
        (.worktree.branch // "")
    ')
    EOF

    # --- Derived values ---
    DIRNAME=$(${pkgs.coreutils}/bin/basename "$DIR")
    MIN=$((DURATION_MS / 1000 / 60))
    SEC=$((DURATION_MS / 1000 % 60))
    DURATION_FMT=$(printf "%dm %02ds" "$MIN" "$SEC")

    BAR_WIDTH=10

    # Usage: repeat_bar COUNT
    repeat_bar() {
        i=0
        while [ "$i" -lt "$1" ]; do
            printf "━"
            i=$((i + 1))
        done
    }

    # Usage: render_bar PERCENTAGE
    # Outputs a colored 10-char bar followed by the percentage
    render_bar() {
        pct=$1
        filled=$((pct * BAR_WIDTH / 100))
        empty=$((BAR_WIDTH - filled))

        if [ "$pct" -lt 50 ]; then
            color=$GREEN
        elif [ "$pct" -lt 80 ]; then
            color=$YELLOW
        else
            color=$RED
        fi

        printf "%s" "$color"; repeat_bar "$filled"
        printf "%s" "$BRBLACK"; repeat_bar "$empty"
        printf "%s%3d%%%s" "$color" "$pct" "$NORMAL"
    }

    printf "%s📁 %s" "$BLUE" "$DIRNAME"
    printf "%s | " "$NORMAL"
    printf "%s🤖 %s" "$CYAN" "$MODEL"
    if [ -n "$VERSION" ]; then
        printf "%s %sv%s" "$NORMAL" "$BRBLACK" "$VERSION"
    fi
    printf "%s | " "$NORMAL"
    printf "%s🕐 %s" "$CYAN" "$DURATION_FMT"
    printf "%s | " "$NORMAL"
    if [ -n "$BRANCH" ]; then
        printf "%s⎇  %s%s " "$CYAN" "$BRANCH" "$NORMAL"
    fi
    printf "%s+%d" "$GREEN" "$LINES_ADD"
    printf "%s " "$NORMAL"
    printf "%s-%d" "$RED" "$LINES_DEL"
    printf "%s | " "$NORMAL"
    printf "%sCTX " "$BLUE"
    render_bar "$PCT_CTX"
    printf "%s   " "$NORMAL"
    printf "%s5H " "$BLUE"
    render_bar "$PCT_5H"
    printf "%s   " "$NORMAL"
    printf "%s7D " "$BLUE"
    render_bar "$PCT_7D"
    printf "%s\n" "$NORMAL"
  '';
}
