#!/etc/profiles/per-user/nixos/bin/fish

set -l input (cat)

# --- Parse all fields ---
set -l MODEL       (echo $input | jq -r '.model.display_name // "unknown"')
set -l VERSION     (echo $input | jq -r '.version // ""')
set -l DIR         (echo $input | jq -r '.workspace.current_dir // "."')
set -l DURATION_MS (echo $input | jq -r '.cost.total_duration_ms // 0')
set -l COST        (echo $input | jq -r '.cost.total_cost_usd // 0')
set -l LINES_ADD   (echo $input | jq -r '.cost.total_lines_added // 0')
set -l LINES_DEL   (echo $input | jq -r '.cost.total_lines_removed // 0')
set -l PCT_CTX     (echo $input | jq -r '.context_window.used_percentage // 0')
set -l PCT_5H      (echo $input | jq -r '.rate_limits.five_hour.used_percentage // 0')
set -l PCT_7D      (echo $input | jq -r '.rate_limits.seven_day.used_percentage // 0')
set -l BRANCH      (echo $input | jq -r '.worktree.branch // ""')

# --- Derived values ---
set -l DIRNAME (basename $DIR)
set -l MIN     (math -s0 $DURATION_MS / 1000 / 60)
set -l SEC     (math -s0 $DURATION_MS / 1000 % 60)
set -l DURATION_FMT (printf "%dm %02ds" $MIN $SEC)

# --- Bar renderer ---
# Usage: render_bar PERCENTAGE
# Outputs a colored 10-char bar followed by the percentage, using set_color
function render_bar
    set -l pct $argv[1]
    set -l BAR_WIDTH 10
    set -l filled (math -s0 $pct \* $BAR_WIDTH / 100)
    set -l empty  (math -s0 $BAR_WIDTH - $filled)

    set -l fill_str ""
    set -l pad_str  ""
    test $filled -gt 0; and set fill_str (string repeat -n $filled "━")
    test $empty  -gt 0; and set pad_str  (string repeat -n $empty  "━")

    set -l color

    if test $pct -lt 50
        set color "green"
    else if test $pct -lt 80
        set color "yellow"
    else
        set color "red"
    end

    set_color $color; printf "%s" $fill_str
    set_color brblack; printf "%s" $pad_str
    set_color $color; printf "%3d%%" $pct
    set_color normal
end

set_color blue;   printf "📁 %s" $DIRNAME
set_color normal; printf " | "
set_color cyan;   printf "🤖 %s" $MODEL
if test -n "$VERSION"
    set_color normal; printf " "
    set_color brblack; printf "v%s" $VERSION
end
set_color normal; printf " | "
set_color cyan;   printf "🕐 %s" $DURATION_FMT
set_color normal; printf " | "
if test -n "$BRANCH"
    set_color cyan;   printf "⎇  %s" $BRANCH
    set_color normal; printf " "
end
set_color green;  printf "+%d" $LINES_ADD
set_color normal; printf " "
set_color red;    printf "-%d" $LINES_DEL
set_color normal; printf " | "
set_color blue;   printf "CTX "
render_bar (math -s0 $PCT_CTX)
set_color normal; printf "   "
set_color blue;   printf "5H "
render_bar (math -s0 $PCT_5H)
set_color normal; printf "   "
set_color blue;   printf "7D "
render_bar (math -s0 $PCT_7D)
set_color normal
printf "\n"
