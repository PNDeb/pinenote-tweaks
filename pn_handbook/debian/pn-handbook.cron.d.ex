#
# Regular cron jobs for the pn-handbook package.
#
0 4	* * *	root	[ -x /usr/bin/pn-handbook_maintenance ] && /usr/bin/pn-handbook_maintenance
