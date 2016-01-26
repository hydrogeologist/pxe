#!/bin/bash
set -e

ip=$1

STATUS=`grep $ip /etc/dnsmasq.conf`
if [ $? -eq 1 ]; then
   echo "Set DHCP IP/Range:"
   prefix=${ip%.*}
   sed -i "s/192.168.103.11/$ip/g" /etc/dnsmasq.conf
   sed -i "s/192.168.103/$prefix/g"  /etc/dnsmasq.conf
   echo "$ip pxe.ravihuang.net" >> /etc/hosts
fi

echo "Start Services:"
service nginx start
exec dnsmasq --no-daemon

