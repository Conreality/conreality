#
# Regular cron jobs for the ocaml-lua package
#
0 4	* * *	root	[ -x /usr/bin/ocaml-lua_maintenance ] && /usr/bin/ocaml-lua_maintenance
