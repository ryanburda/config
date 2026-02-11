#!/bin/bash

BACKGROUNDS_DIR="$HOME/Developer/assets/assets/backgrounds"
ENVY_KEY="background"

selected=$(ls "$BACKGROUNDS_DIR" | fzf --preview "chafa --size=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES} $BACKGROUNDS_DIR/{}" --preview-window=up,80%)

[ -z "$selected" ] && exit 0

full_path="$BACKGROUNDS_DIR/$selected"

envy set "$ENVY_KEY" "$full_path"

pkill swaybg
# sleep 0.2
setsid -f swaybg -i "$full_path" -m fill &>/dev/null
