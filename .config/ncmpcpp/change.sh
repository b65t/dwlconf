#!/bin/bash

music_dir="$HOME/Music"
current_file=$(ncmpcpp --current-song "%f")
output_cover="/tmp/cover.png"

ffmpeg -i "$music_dir/$current_file" -an -vcodec copy "$output_cover" -y 2>/dev/null

if [ -f "$output_cover" ]; then
  song_info=$(ncmpcpp --current-song "%t - %a")
  notify-send "Now Playing" "$song_info" -i "$output_cover"
else
  notify-send "Now Playing" "$(ncmpcpp --current-song "%t - %a")"
fi
