#!/bin/zsh

# Add custom scripts to PATH
export PATH="$HOME/.local/bin:$PATH"
# Directories for tsm (tmux session manager)
export TSM_DIRS_CMD='{
    echo "$HOME"
    find "$HOME" -maxdepth 2 -name .git -type d 2>/dev/null | sed "s|/.git$||"
    find "$HOME/Developer" -maxdepth 4 -name .git -type d 2>/dev/null | sed "s|/.git$||"
}'
