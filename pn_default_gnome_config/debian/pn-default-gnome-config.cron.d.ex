#
# Regular cron jobs for the pn-default-gnome-config package.
#
0 4	* * *	root	[ -x /usr/bin/pn-default-gnome-config_maintenance ] && /usr/bin/pn-default-gnome-config_maintenance
