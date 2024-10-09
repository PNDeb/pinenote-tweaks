#!/bin/sh
echo "PineNote: Waiting for cover-close events..."
event_close='*type 5 (EV_SW), code 16 (?), value 1'

evtest "/dev/input/by-path/platform-gpio-keys-event" | while read line; do
   case $line in
	($event_close)
	       	echo "LID CLOSED"
			# echo mem > /sys/power/state
			systemctl suspend
	       	;;
   esac
done
