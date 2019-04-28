# Collection of scripts and configurations 
Let's save your local desktop public ipv6 address on your remote webserver, where your personal webpage usually lingers.

## myip

Following every boot up, your desktop will try to copy its current public ip, typically ipv6 on Virgin networks, onto your remote server. There you can define some alias to talk back to your desktop. Take into account that both local desktop and remote server got its ssh keys properly configured.

```
if [ -f /home/user/archlinux.txt]; then
	alias archlinux="ssh user@`cat /home/user/archlinux.txt` "
fi
``` 
