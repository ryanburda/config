#!/bin/sh

option=$(printf "lock\nshutdown\nrestart\nlogout" | fuzzel --dmenu --prompt "")

case "$option" in
    lock)
        swaylock
        ;;
    shutdown)
        systemctl poweroff
        ;;
    restart)
        systemctl reboot
        ;;
    logout)
        loginctl terminate-user "$USER"
        ;;
esac
