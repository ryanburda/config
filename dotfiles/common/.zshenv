#!/bin/zsh

# Add custom scripts to PATH
export PATH="$HOME/.local/bin:$PATH"

# Keep on one line: niri-session runs a bare `systemctl --user import-environment`,
# which warns about control characters (newlines) in any exported variable.
export TSM_DIRS_CMD='{ find "$HOME" -maxdepth 1 -name ".*" -prune -o -type d -print; find "$HOME/code" -name ".*" -prune -o -type d \( -exec test -f "{}/.git" \; -print -prune -o -print \); }'

export TSM_GIT_DIRS_CMD='find "$HOME/code" -maxdepth 4 -name ".git" -prune -print 2>/dev/null | while IFS= read -r g; do [ -d "$g" ] && grep -q "^[[:space:]]*bare = true" "$g/config" 2>/dev/null && continue; echo "${g%/.git}"; done'
