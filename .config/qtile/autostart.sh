#!/usr/bin/bash
# xset commands disable screen saver
xset -dpms &
xset s off &
# picom enables transparent tiles
picom -b --experimental-backends
# nitrogen for backgrounds
nitrogen --restore &
