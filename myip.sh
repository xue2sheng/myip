#!/usr/bin/sh
/usr/bin/sleep 10s
/usr/bin/dig TXT +short o-o.myaddr.google.com @ns1.google.com > /home/user/archlinux.txt
/usr/bin/sed -i -e 's/"//g' /home/user/archlinux.txt
/usr/bin/cp /home/user/archlinux.txt /home/user/index.html
/usr/bin/sed -i -e 's/\(.*\)/<!DOCTYPE html><html><head><title>Archlinux<\/title><\/head><body><a href="https:\/\/[\1]">\1<\/a><\/body><\/html>/g' /home/user/index.html
/usr/bin/scp /home/user/archlinux.txt user@xue2sheng.com:/home/user/archlinux.txt
/usr/bin/scp /home/user/index.html user@xue2sheng.com:/home/user/index.html
# expected softlink at the server index.html --> /var/www/desktop/index.html
