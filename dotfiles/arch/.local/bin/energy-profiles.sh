#!/bin/zsh

# TODO: display the current profile
option=$(printf "power-saver\nbalanced\nperformance" | fuzzel --dmenu --prompt "")
powerprofilesctl set $option
