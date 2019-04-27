#!/usr/bin/env bash
if [ -s /home/user/archlinux.txt ]
then	
	ssh -f user@$(cat /home/user/archlinux.txt) -L 9999:127.0.0.1:9999 -N
else
	echo "Empty ipv6 archlinux file"
	exit 1
fi
