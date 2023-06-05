#
# Regular cron jobs for the pinenote-suspend-on-cover package.
#
0 4	* * *	root	[ -x /usr/bin/pinenote-suspend-on-cover_maintenance ] && /usr/bin/pinenote-suspend-on-cover_maintenance
