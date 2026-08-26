#!/usr/bin/env bash
# Claude Code statusLine — Claude-native (no Starship mirroring)
# Directory (cyan) · git branch (purple) · model (dim) · session name (dim) ·
# PR status (dim) · context remaining (green/yellow/red) · rate limits (dim)

input=$(cat)
cwd=$(echo "$input"   | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
effort=$(echo "$input" | jq -r '.effort.level // empty')
session_name=$(echo "$input" | jq -r '.session_name // empty')
ctx_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
ctx_used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
rl_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rl_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

# --- Directory (~ for home) ---
home="$HOME"
dir="${cwd/#$home/\~}"

# --- Git branch ---
branch=""
if git --no-optional-locks -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git --no-optional-locks -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
             || git --no-optional-locks -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# --- Render ---
# cyan=36, purple=35, dim=2, green=32, yellow=33, red=31, reset=0
printf '\033[36m%s\033[0m' "$dir"
[ -n "$branch" ] && printf ' \033[35m%s\033[0m' "$branch"
printf ' \033[2m%s\033[0m' "$model"
[ -n "$effort" ] && printf ' \033[2m(%s)\033[0m' "$effort"

# --- Session name ---
[ -n "$session_name" ] && printf ' \033[2m%s\033[0m' "$session_name"

# --- Line 2: PR status, context, rate limits ---
printf '\n'

# --- Context remaining ---
format_k() {
    local n=$1
    if [ "$n" -ge 1000 ]; then
        awk -v n="$n" 'BEGIN{printf "%.0fk", n/1000}'
    else
        echo "$n"
    fi
}

if [ -n "$ctx_remaining" ]; then
    ctx_int=${ctx_remaining%.*}
    if [ "$ctx_int" -gt 50 ]; then
        ctx_color=32
    elif [ "$ctx_int" -ge 20 ]; then
        ctx_color=33
    else
        ctx_color=31
    fi
    ctx_label="ctx ${ctx_int}%"
    if [ -n "$ctx_used_tokens" ] && [ -n "$ctx_size" ]; then
        ctx_label="$ctx_label ($(format_k "$ctx_used_tokens")/$(format_k "$ctx_size"))"
    fi
    printf ' \033[%sm%s\033[0m' "$ctx_color" "$ctx_label"
fi

# --- Rate limits ---
if [ -n "$rl_5h" ] || [ -n "$rl_7d" ]; then
    rl_out=""
    [ -n "$rl_5h" ] && rl_out="5h $(printf '%.0f' "$rl_5h")%"
    if [ -n "$rl_7d" ]; then
        rl_7d_fmt="7d $(printf '%.0f' "$rl_7d")%"
        [ -n "$rl_out" ] && rl_out="$rl_out · $rl_7d_fmt" || rl_out="$rl_7d_fmt"
    fi
    printf ' \033[2m%s\033[0m' "$rl_out"
fi

# --- Last message time (relative age from transcript) ---
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
    last_ts=$(tail -n 1 "$transcript_path" | jq -r '.timestamp // empty' 2>/dev/null)
    if [ -n "$last_ts" ]; then
        # strip fractional seconds and trailing Z: 2026-07-22T23:19:46.691Z -> 2026-07-22T23:19:46
        clean_ts=${last_ts%.*}
        clean_ts=${clean_ts%Z}
        last_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "$clean_ts" +%s 2>/dev/null)
        if [ -n "$last_epoch" ]; then
            age=$(( $(date +%s) - last_epoch ))
            [ "$age" -lt 0 ] && age=0
            if [ "$age" -lt 60 ]; then
                age_label="${age}s ago"
            elif [ "$age" -lt 3600 ]; then
                age_label="$(( age / 60 ))m ago"
            elif [ "$age" -lt 86400 ]; then
                age_label="$(( age / 3600 ))h ago"
            else
                age_label="$(( age / 86400 ))d ago"
            fi
            # Cache-TTL awareness: this session caches with a 1h TTL, refreshed on
            # each message. Warn as the window closes; flag once likely expired.
            if [ "$age" -lt 2700 ]; then       # < 45m: comfortably warm
                age_color=2;  cache_mark=""
            elif [ "$age" -lt 3600 ]; then     # 45–60m: expiring soon
                age_color=33; cache_mark=" cache≈expiring"
            else                               # > 60m: cache likely cold
                age_color=31; cache_mark=" cache❄cold"
            fi
            printf ' \033[%sm⏱ %s%s\033[0m' "$age_color" "$age_label" "$cache_mark"
        fi
    fi
fi
