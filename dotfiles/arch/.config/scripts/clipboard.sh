#!/bin/sh
cliphist list | fuzzel --dmenu --prompt "" | cliphist decode | wl-copy
