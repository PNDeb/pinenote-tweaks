#
# Regular cron jobs for the pn-default-documents package.
#
0 4	* * *	root	[ -x /usr/bin/pn-default-documents_maintenance ] && /usr/bin/pn-default-documents_maintenance
