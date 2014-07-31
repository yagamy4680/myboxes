#!/bin/bash
ip="192.168.7.230"
gateway="192.168.7.1"
dns="8.8.8.8"

ifconfig eth1 down
ifconfig eth1 ${ip} up
route del default
route add default gw ${gateway} dev eth1
service apache2 restart
EOL

cat >/etc/resolv.conf <<EOL
nameserver ${dns}
EOL
