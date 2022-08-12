#!/usr/bin/bash
# xset commands disable screen saver
xset -dpms &
xset -q &
# picom enables transparent tiles
picom -b
# nitrogen for backgrounds
nitrogen --restore &
