#
# Regular cron jobs for the pinenote-python-scripts package.
#
0 4	* * *	root	[ -x /usr/bin/pinenote-python-scripts_maintenance ] && /usr/bin/pinenote-python-scripts_maintenance
