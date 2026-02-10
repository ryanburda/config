#!/bin/sh

history_file="${XDG_CACHE_HOME:-$HOME/.cache}/launcher_history"
touch "$history_file"

# Collect desktop application names
apps=""
for dir in /usr/share/applications ~/.local/share/applications; do
    [ -d "$dir" ] || continue
    for file in "$dir"/*.desktop; do
        [ -f "$file" ] || continue
        grep -q "^NoDisplay=true" "$file" && continue
        grep -q "^Type=Application" "$file" || continue
        name=$(grep -m1 "^Name=" "$file" | cut -d= -f2-)
        [ -n "$name" ] && apps="$apps$name\n"
    done
done

settings="settings: sound\nsettings: wifi\nsettings: bluetooth\nsettings: monitor"
power="power: lock\npower: shutdown\npower: restart\npower: logout"

all=$(printf "%b%b\n%b" "$apps" "$settings" "$power" | sort -u)

# Sort by history: recent entries first, then the rest
recent=$(tac "$history_file" | awk '!seen[$0]++')
ordered=$(printf "%s\n%s" "$recent" "$all" | awk 'NF && !seen[$0]++')

option=$(printf "%s" "$ordered" | fuzzel --dmenu --prompt "")

[ -z "$option" ] && exit 0

# Record selection to history
echo "$option" >> "$history_file"

case "$option" in
    "settings: sound")     wezterm start -- wiremix -v output ;;
    "settings: wifi")      wezterm start -- impala ;;
    "settings: bluetooth") wezterm start -- bluetui ;;
    "settings: monitor")   wezterm start -- btm --rate 5s ;;
    "power: lock")         swaylock ;;
    "power: shutdown")     systemctl poweroff ;;
    "power: restart")      systemctl reboot ;;
    "power: logout")       loginctl terminate-user "$USER" ;;
    *)
        # Launch the selected desktop application
        for dir in ~/.local/share/applications /usr/share/applications; do
            [ -d "$dir" ] || continue
            for file in "$dir"/*.desktop; do
                [ -f "$file" ] || continue
                name=$(grep -m1 "^Name=" "$file" | cut -d= -f2-)
                if [ "$name" = "$option" ]; then
                    gtk-launch "$(basename "$file")"
                    exit 0
                fi
            done
        done
        ;;
esac
