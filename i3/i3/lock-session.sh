#!/bin/bash

bg="$HOME/.config/backgrounds/shaded-landscape.jpeg"
tmpbg='/tmp/screen.png'

convert "$bg" -scale 5% -scale 1000% -fill black -colorize 25% "$tmpbg"
i3lock -t -i "$tmpbg"
rm "$tmpbg"
