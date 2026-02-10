#!/bin/sh

option=$(printf "Sound\nWiFi\nBluetooth\nDisplays" | fuzzel --dmenu --prompt "")

case "$option" in
    Sound)
        wezterm start -- wiremix -v output
        ;;
    WiFi)
        wezterm start -- impala
        ;;
    Bluetooth)
        wezterm start -- bluetui
        ;;
    Displays)
        wezterm start -- wdisplays
        ;;
esac
