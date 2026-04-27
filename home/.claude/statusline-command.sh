#!/usr/bin/env bash
# Claude Code status line command
# Receives JSON via stdin from Claude Code

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(echo "$input" | jq -r '.effortLevel // "normal"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build parts array
parts=()

[ -n "$cwd" ] && parts+=("${cwd/#$HOME/~} ·")
[ -n "$model" ] && parts+=("model:$model ·")
[ -n "$effort" ] && parts+=("effort:$effort")
[ -n "$used_pct" ] && parts+=("· ctx:$(printf '%.0f' "$used_pct")%")

printf '%s' "$(IFS=' | '; echo "${parts[*]}")"
