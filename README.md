# Collection of scripts and configurations 
Let's save your local desktop public ipv6 address on your remote webserver, where your personal webpage usually lingers.

## Public IP 

Following every boot up, your desktop will try to [copy its current public ip](myip.sh), typically ipv6 on current ISP, onto your remote server. There you can define some alias to talk back to your desktop. Take into account that both local desktop and remote server got its ssh keys properly configured.

```
if [ -f /home/user/archlinux.txt]; then
	alias archlinux="ssh user@`cat /home/user/archlinux.txt` "
fi
``` 

## Hidden link to public IP

Once you got that desktop address information on your server, you can make it **semi-public** by means of a hidden link on your personal webpage:

1) mginx (commented out protection by password): 

```
    location /desktop/ {
        alias /var/www/desktop/;
#	autoindex on;
#	auth_basic "Restricted Content";
#       auth_basic_user_file /etc/nginx/.htpasswd;
    }
```

2) HTML code:

```
<a title="Desktop" href="/desktop/index.html" target="_blank">&nbsp;&nbsp;&nbsp;</a>
```
