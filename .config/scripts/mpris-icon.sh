#!/bin/bash

prev_hash=""

while true; do
    album_art=$(playerctl metadata mpris:artUrl 2>/dev/null)

    if [[ -n $album_art ]]; then
        curl -s "$album_art" --output "/tmp/cover.jpeg"

        new_hash=$(md5sum /tmp/cover.jpeg | awk '{print $1}')

        if [[ "$new_hash" != "$prev_hash" ]]; then
            prev_hash="$new_hash"
            kill -SIGUSR2 $(pidof waybar)
        fi
    fi

    sleep 5
done
