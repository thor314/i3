#!/bin/bash
MAX=48000
MIN=10
set -e
file="/sys/class/backlight/intel_backlight/brightness"
current=$(cat "$file")
new="$current"
if [ "$2" != "" ]; then
    val=$(echo "$2*$MAX/100" | bc)
fi
if [ "$1" = "-inc" ]; then
    new=$(( current + $val ))
elif [ "$1" = "-dec" ]; then
    new=$(( current - $val ))
fi
if [ $new -gt $MAX ]; then
    new=$MAX
elif [ $new -lt $MIN ]; then
    new=$MIN
fi
printf "%.0f%%\n" $(echo "$new/$MAX*100" | bc -l)
echo $new > "$file"
