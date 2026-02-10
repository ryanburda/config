#!/bin/sh

option=$(printf "sound\nwifi\nbluetooth" | fuzzel --dmenu --prompt "")

case "$option" in
    sound)
        wezterm start -- wiremix -v output
        ;;
    wifi)
        wezterm start -- impala
        ;;
    bluetooth)
        wezterm start -- bluetui
        ;;
esac
