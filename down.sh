#! /bin/bash
DEV=$1
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/.env"

CACHE_NAMESERVER="$TEMP_DIR/$DEV.nameserver"

if [ -f $CACHE_NAMESERVER ]; then
	for ns in `cat $CACHE_NAMESERVER`; do
	
		echo "Removing $ns from /etc/resolv.conf"
		cat /etc/resolv.conf | grep -v "nameserver $ns" > /tmp/resolv.conf
		mv /tmp/resolv.conf /etc/resolv.conf
		
	done
fi
