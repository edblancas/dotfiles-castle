#!/usr/bin/env bash
# Claude Code status line command
# Receives JSON via stdin from Claude Code

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
[ -z "$effort" ] && effort=$(jq -r '.effortLevel // empty' ~/.claude/settings.json 2>/dev/null)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')

# Build parts array
parts=()

[ -n "$cwd" ] && parts+=("${cwd/#$HOME/~} ·")
[ -n "$model" ] && parts+=("model:$model ·")
[ -n "$effort" ] && parts+=("effort:$effort")
if [ -n "$used_pct" ]; then
  ctx_str="ctx:$(printf '%.0f' "$used_pct")%"
  if [ -n "$total_tokens" ] && [ "$total_tokens" != "0" ]; then
    token_k=$(( (total_tokens + 500) / 1000 ))
    ctx_str="$ctx_str (${token_k}k)"
  fi
  parts+=("· $ctx_str")
fi

printf '%s' "$(IFS=' | '; echo "${parts[*]}")"
