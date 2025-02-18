#!/bin/bash

# Setup
format='.png'
datetime=$(date +"%Y-%m-%d_%H-%M-%S")

tmpfile=$(mktemp)
tmpscreenshot="${tmpfile}${format}"

targetdir=${1:-"$HOME/Pictures/Screenshots"}
targetfile="$targetdir/screenshot-$datetime$format"

# Extract focused window id from i3's tree
focused_window=$(i3-msg -t get_tree | jq '.. | select(.focused? == true).window' | head -n 1)

# execution
mv "$tmpfile" "$tmpscreenshot"
import -window "$focused_window" "$tmpscreenshot"
cp "$tmpscreenshot" "$targetfile"
rm "$tmpscreenshot"
notify-send -t 5000 "Screenshot saved to $targetfile"
xclip -selection clipboard -target image/png -i "$targetfile"
