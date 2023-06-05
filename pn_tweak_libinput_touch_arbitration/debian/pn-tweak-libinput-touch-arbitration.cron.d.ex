#
# Regular cron jobs for the pn-tweak-libinput-touch-arbitration package.
#
0 4	* * *	root	[ -x /usr/bin/pn-tweak-libinput-touch-arbitration_maintenance ] && /usr/bin/pn-tweak-libinput-touch-arbitration_maintenance
