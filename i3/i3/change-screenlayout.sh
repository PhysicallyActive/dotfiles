#!/usr/bin/env bash

DIR="$(readlink -f "${SCREENLAYOUT_DIR:-$HOME/.config/screenlayouts}")"
CURRENT="$DIR/current-screenlayout.sh"

[ -e "$DIR" ] || exit 1

name="$(find "$DIR" -maxdepth 1 -type f -name '*.sh' -printf '%f\n' |
  grep -v '^current-screenlayout\.sh$' |
  sed 's/\.sh$//' |
  sort |
  rofi -dmenu -i -p Layout)" || exit 0

[ -n "$name" ] || exit 0
src="$DIR/$name.sh"

cp "$src" "$CURRENT"

notify-send "Applying screen layout: $name"
bash "$CURRENT"
