#!/usr/bin/env bash
set -euo pipefail


sink=$(pactl get-default-sink)

if pactl list sinks | rg  -q 'Active Port: analog-output-lineout'; then
    pactl set-sink-port "$sink" analog-output-headphones
    notify-send -t 1000 "Audio output" "Headphones"
else
    pactl set-sink-port "$sink" analog-output-lineout
    notify-send -t 1000 "Audio output" "Speakers"
fi





