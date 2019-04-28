#!/usr/bin/sh
/usr/bin/sleep 10s
/usr/bin/dig TXT +short o-o.myaddr.google.com @ns1.google.com > /home/user/archlinux.txt
/usr/bin/sed -i -e 's/"//g' /home/user/archlinux.txt
/usr/bin/scp /home/user/archlinux.txt user@xue2sheng.com:/home/user/archlinux.txt
/usr/bin/scp /home/user/archlinux.txt user@xue2sheng.com:/var/www/desktop/index.html
