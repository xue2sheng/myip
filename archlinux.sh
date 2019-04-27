#!/usr/bin/env bash
if [ -s /home/user/archlinux.txt ]
then	
	ssh -NTC -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=no user@$(cat /home/user/archlinux.txt) -L 9999:127.0.0.1:9999
fi
