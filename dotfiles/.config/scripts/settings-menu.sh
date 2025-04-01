#!/bin/sh

option=$(printf "sound\nwifi\nbluetooth\nmonitor" | fuzzel --dmenu --prompt "")

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
    monitor)
        wezterm start -- btm --rate 5s
        ;;
esac
