#!/bin/zsh

option=$(printf "Sound\nWiFi\nBluetooth\nDisplays\nBackground\nEnergy Profile" | sort | fuzzel --dmenu --prompt "")

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
    Background)
        wezterm start -- background-selector.sh
        ;;
    Energy\ Profile)
        energy-profiles.sh
        ;;
esac
