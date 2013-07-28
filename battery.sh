#!/bin/bash

__charging=0
__pct=100
__sleeptime=10

updateStatus_debug() {
	# for debugging, the light simulates battery charging status (on = charging).
	# The volume simulates the battery percentage.
	__charging=$(cat /proc/acpi/ibm/light | head -n1 | grep -c on)
	__pct=$(amixer get Master | tail -n 1 | cut -d "[" -f 2 | cut -d "%" -f 1)
}

updateStatus() {
	acpi | grep Discharging
	__charging=$?
	__pct=$(acpi | cut -d' ' -f4 | cut -d'%' -f1)
}

while [ 1 ]; do
	updateStatus
	
	if [ $__charging = 0 ]; then
		while [ $__pct -lt 25 -a $__charging = 0 ]; do
			__color="white"
			if [ $__pct -lt 20 ]; then
				__color="red";
			fi
			echo Battery warning: $__pct% | osd_cat -d $__sleeptime -f "-*-terminal-*-r-*-*-*-*-*-*-*-*-*-*" -c $__color -u black -O 1 -p top -A center -s3
			updateStatus
		done
	fi
	sleep $__sleeptime
done

exit 0