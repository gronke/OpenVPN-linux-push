#! /bin/bash
DEV=$1
CACHE_NAMESERVER="/tmp/openvpn/$DEV.nameserver"
echo $CACHE_NAMESERVER

if [ -f $CACHE_NAMESERVER ]; then
	for ns in `cat $CACHE_NAMESERVER`; do
	
		echo "Removing $ns from /etc/resolv.conf"
		cat /etc/resolv.conf | grep -v "nameserver $ns" > /tmp/resolv.conf
		mv /tmp/resolv.conf /etc/resolv.conf
		
	done
fi
