#!/bin/bash

# Setup
format='.png'
datetime=$(date +"%Y-%m-%d_%H-%M-%S")

tmpfile=$(mktemp)
tmpscreenshot="${tmpfile}${format}"

targetdir=${1:-"$HOME/Pictures/Screenshots"}
targetfile="$targetdir/screenshot-$datetime$format"

# Required to allow i3 to finish processing the keyevent before allowing imagemagick to take over
sleep 0.3

# execution
mv "$tmpfile" "$tmpscreenshot"
import "$tmpscreenshot"
cp "$tmpscreenshot" "$targetfile"
rm "$tmpscreenshot"
notify-send -t 5000 "Screenshot saved to $targetfile"
xclip -selection clipboard -target image/png -i "$targetfile"
