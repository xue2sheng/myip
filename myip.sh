#!/usr/bin/env bash
dig TXT +short o-o.myaddr.google.com @ns1.google.com | sed -e "s/\"//g" > /home/user/archlinux.txt
scp /home/user/archlinux.txt user@xue2sheng.com:/home/user/archlinux.txt
