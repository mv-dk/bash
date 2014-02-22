#!/bin/bash

gm=`xgamma 2>&1 | cut -c 9-13`
newGm="1.0"
case $1 in
  "up")
	newGm=`echo "scale=3; $gm+0.1" | bc`
    xgamma -gamma $newGm
  ;;
  "down")
    newGm=`echo "scale=3; $gm-0.1" | bc`
    xgamma -gamma $newGm
  ;;
  *)
	xgamma -gamma 1.0
  ;;
esac

killall osd_cat &> /dev/null
echo "Gamma: $newGm" | osd_cat -d 1 -A center -p top -c red -o 30 -f "-*-terminal-*-r-*-*-*-*-*-*-*-*-*-*" -u black -O 1 &

exit 0