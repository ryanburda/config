#!/bin/zsh

# Add custom scripts to PATH
export PATH="$HOME/.local/bin:$PATH"

export TSM_DIRS_CMD='{
  find "$HOME" -maxdepth 1 -name ".*" -prune -o -type d -print;
  find "$HOME/code" -maxdepth 4 -name ".*" -prune -o -type d -print;
}'

export TSM_GIT_DIRS_CMD='for f in "$HOME/.config/tsm/"*.sh; do ROOT=""; source "$f"; [ -n "$ROOT" ] && echo "$ROOT"; done'
