#!/bin/zsh

# Add custom scripts to PATH
export PATH="$HOME/.local/bin:$PATH"
# Only search
export TSM_DIRS_CMD="{ echo "$HOME"; find "$HOME" -maxdepth 1 -type d -exec test -d '{}/.git' \; -print -prune 2>/dev/null; find "$HOME/Developer/" -maxdepth 3 -type d -exec test -d '{}/.git' \; -print -prune 2>/dev/null; }"
