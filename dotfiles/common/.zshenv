#!/bin/zsh

# Add custom scripts to PATH
export PATH="$HOME/.local/bin:$PATH"

export TSM_DIRS_CMD='{
  find "$HOME" -maxdepth 1 -name ".*" -prune -o -type d -print;
  find "$HOME/code" -maxdepth 3 -name ".*" -prune -o -type d \( -exec test -e {}/.git \; -print -prune -o -print \);
}'

export TSM_GIT_DIRS_CMD='find "$HOME/code" -maxdepth 4 -name ".git" 2>/dev/null | sed "s/\/\.git$//"'
