#
# Regular cron jobs for the pn-defaut-xpp-config package.
#
0 4	* * *	root	[ -x /usr/bin/pn-defaut-xpp-config_maintenance ] && /usr/bin/pn-defaut-xpp-config_maintenance
