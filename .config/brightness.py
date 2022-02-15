#!/usr/bin/env python3
import sys

# Simple script to manage brightness of the display.

# Min brightness (to not turn out monitor completely)
MIN_BRIGHTNESS = 1
# Max brightness supported by the monitor on the target machine
MAX_BRIGHTNESS = 512
# Path to the current brightness file
BRIGHTNESS_FILE_PATH = "/sys/class/backlight/intel_backlight/brightness"

# Expects something like '-16' or '+16'
change = int(sys.argv[1])

cur_brightness = MAX_BRIGHTNESS
with open(BRIGHTNESS_FILE_PATH, mode="r") as f:
    cur_brightness = int(f.read())

with open(BRIGHTNESS_FILE_PATH, mode="w") as f:
    new_val = cur_brightness + change
    new_val = min(new_val, MAX_BRIGHTNESS)
    new_val = max(new_val, MIN_BRIGHTNESS)
    f.write(str(new_val))

