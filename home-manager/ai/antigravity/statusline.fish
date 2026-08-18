#!/etc/profiles/per-user/nixos/bin/fish

set -l input (cat)

# --- Parse all fields ---
set -l MODEL     (echo $input | jq -r '.model.display_name // "unknown"')
set -l EFFORT    (echo $input | jq -r '.model.effort // ""')
set -l VERSION   (echo $input | jq -r '.version // ""')
set -l DIR       (echo $input | jq -r '.workspace.current_dir // .cwd // "."')
set -l PCT_CTX   (echo $input | jq -r '.context_window.used_percentage // 0')
set -l PLAN_TIER (echo $input | jq -r '.plan_tier // ""')
set -l GEMINI_FRAC  (echo $input | jq -r '.quota."gemini-weekly".remaining_fraction // 1')
set -l GEMINI_RESET (echo $input | jq -r '.quota."gemini-weekly".reset_in_seconds // 0')

# --- Derived values ---
set -l DIRNAME (basename $DIR)

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
if test -n "$EFFORT"
    set_color normal; printf " "
    set_color brblack; printf "(%s)" $EFFORT
end
if test -n "$VERSION"
    set_color normal; printf " "
    set_color brblack; printf "v%s" $VERSION
end
set_color normal; printf " | "
set_color blue;   printf "CTX "
render_bar (math -s0 $PCT_CTX)

set_color normal; printf "   "
set_color blue;   printf "7D "
render_bar (math -s0 "(1 - $GEMINI_FRAC) * 100")
if test $GEMINI_RESET -gt 0
    set_color normal; printf " "
    set_color brblack; printf "(resets %dd)" (math -s0 $GEMINI_RESET / 86400)
end

if test -n "$PLAN_TIER"
    set_color normal; printf " | "
    set_color brblack; printf "%s" $PLAN_TIER
end

set_color normal
printf "\n"
