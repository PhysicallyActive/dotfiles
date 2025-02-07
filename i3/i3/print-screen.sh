#!/bin/bash

tmpfile=$(mktemp)
format='.png'
tmpscreenshot="${tmpfile}${format}"
targetdir=${1:-"$HOME/Pictures/Screenshots"}
datetime=$(date +"%Y-%m-%d_%H-%M-%S")
targetfile="$targetdir/screenshot-$datetime$format"

mv "$tmpfile" "$tmpscreenshot"
import -window root "$tmpscreenshot"
cp "$tmpscreenshot" "$targetfile"
rm "$tmpscreenshot"
xclip -i <"$targetfile"
