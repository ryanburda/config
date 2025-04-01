#!/bin/sh

option=$(printf "power-saver\nbalanced\nperformance" | fuzzel --dmenu --prompt "")
powerprofilesctl set $option
