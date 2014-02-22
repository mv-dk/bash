#!/bin/bash

case $1 in
  "up")
    amixer set Master 2%+
  ;;
  "down")
    amixer set Master 2%-
  ;;
  *)
    amixer set Master $1%
  ;;
esac
vol=`amixer get Master | tail -n 1 | cut -d "[" -f 2 | cut -d "%" -f 1`
killall osd_cat &> /dev/null
osd_cat -b percentage -P $vol -d 1 -A center -p top -c lightgreen -o 30 -T "Volume: $vol%" -f "-*-terminal-*-r-*-*-*-*-*-*-*-*-*-*" -u black -O 1 &

exit 0
