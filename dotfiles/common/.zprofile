#!/bin/zsh

if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Auto-start niri on TTY1
if [[ -z $DISPLAY && -z $WAYLAND_DISPLAY ]]; then
    case $(tty) in
        /dev/tty1) exec niri ;;
        # /dev/tty2) exec cosmic-session ;;
    esac
fi
