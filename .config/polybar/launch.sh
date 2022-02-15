#!/bin/bash

# Terminate already running bars
killall -q i3bar
killall -q polybar

# Wait until they die
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar using 'main' config
polybar main &

echo "Polybar is running now"

