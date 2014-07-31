#!/bin/bash

ip="192.168.7.230/24"
gateway="192.168.7.1"
dns="8.8.8.8"


#####################
# NEW VM
#####################
if [ ! -f /etc/network/if-up.d/custom-network-config ]; then

cat >/etc/network/if-up.d/custom-network-config <<EOL
#!/bin/bash
if [ "\$IFACE" != "eth1" ]; then
exit 0
fi
ifconfig eth1 down
ifconfig eth1 ${ip} up
route del default
route add default gw ${gateway} dev eth1
service apache2 restart
EOL

cat >/etc/resolv.conf <<EOL
nameserver ${dns}
EOL

chmod +x /etc/network/if-up.d/custom-network-config
service networking restart


#####################
# EXISTING VM
#####################
else

service networking restart

fi
