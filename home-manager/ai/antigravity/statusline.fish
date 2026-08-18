#!/etc/profiles/per-user/nixos/bin/fish

set -l input (cat)

# --- Parse all fields ---
set -l MODEL     (echo $input | jq -r '.model.display_name // "unknown"')
set -l EFFORT    (echo $input | jq -r '.model.effort // ""')
set -l VERSION   (echo $input | jq -r '.version // ""')
set -l DIR       (echo $input | jq -r '.workspace.current_dir // .cwd // "."')
set -l PCT_CTX   (echo $input | jq -r '.context_window.used_percentage // 0')
set -l PLAN_TIER (echo $input | jq -r '.plan_tier // ""')
set -l BRANCH    (echo $input | jq -r '.vcs.branch // ""')

# --- Derived values ---
set -l DIRNAME (basename $DIR)

if test -z "$BRANCH"
    set BRANCH (git -C $DIR branch --show-current 2>/dev/null)
end

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
if test -n "$BRANCH"
    set_color cyan;   printf "⎇  %s" $BRANCH
    set_color normal; printf " | "
end
set_color blue;   printf "CTX "
render_bar (math -s0 $PCT_CTX)

for key in (echo $input | jq -r '.quota | keys[]?')
    set -l frac (echo $input | jq -r --arg k $key '.quota[$k].remaining_fraction // 1')
    set -l pct  (math -s0 "(1 - $frac) * 100")
    set -l label (string upper (string split -m1 -- "-" $key)[1])

    set_color normal; printf "   "
    set_color blue;   printf "%s " $label
    render_bar $pct
end

if test -n "$PLAN_TIER"
    set_color normal; printf " | "
    set_color brblack; printf "%s" $PLAN_TIER
end

set_color normal
printf "\n"
