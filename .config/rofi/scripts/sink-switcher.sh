#!/usr/bin/env bash

# List PulseAudio/PipeWire sinks and switch default via rofi

current=$(pactl get-default-sink)

sink_list=$(pactl list sinks short | awk '{print $2}')
display_list=""
active_idx=""
idx=0

for sink in $sink_list; do
    desc=$(pactl list sinks | grep -A 1 "Name: $sink" | grep "Description:" | sed 's/.*Description: //')
    if [[ "$sink" == "$current" ]]; then
        display_list+="* $desc\n"
        active_idx=$idx
    else
        display_list+="  $desc\n"
    fi
    ((idx++))
done

dir="$HOME/.config/rofi/powermenu/type-1"
theme="style-1"

chosen=$(echo -e "$display_list" | sed '/^$/d' | \
    rofi -dmenu -i -p "Audio Output" \
    -theme "${dir}/${theme}.rasi" \
    -theme-str 'listview {lines: 5;}' \
    -theme-str 'textbox-prompt-colon {str: "󰕾";}' \
    ${active_idx:+-a $active_idx})

[ -z "$chosen" ] && exit 0

chosen_desc=$(echo "$chosen" | sed 's/^[* ] //')
chosen_sink=$(pactl list sinks | grep -B 1 "Description: $chosen_desc" | grep "Name:" | sed 's/.*Name: //')

[ -z "$chosen_sink" ] && exit 1

pactl set-default-sink "$chosen_sink"

# Move all currently playing streams to the new sink
pactl list sink-inputs short | awk '{print $1}' | while read -r input; do
    pactl move-sink-input "$input" "$chosen_sink"
done
