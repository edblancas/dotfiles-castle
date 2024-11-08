#!/bin/zsh

kt() {
  # Set the base directory path
  local path_proj="$HOME/projects/onest"
  
  # Use find and fzf to select a directory
  local selected_dir=$(fd . --max-depth 1 --min-depth 1 --type d "$path_proj" | \
    sed "s~$path_proj/~~" | \
    /usr/local/bin/fzf --cycle --layout=reverse --prompt 't> ' | \
    sed "s~^~$path_proj/~")

  # If a directory was selected
  if [[ -n "$selected_dir" ]]; then
    # Extract the tab name from the selected directory
    local tab_name=$(echo "$selected_dir" | sed "s~$path_proj/~~")
    
    # Try to focus an existing tab or launch a new one
    kitty @ focus-tab --match title:"$tab_name" 2>/dev/null || \
    kitty @ launch --type=tab --tab-title "$tab_name" --cwd "$selected_dir" nvim .
  fi
}

kt
