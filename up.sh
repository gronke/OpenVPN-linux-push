#! /bin/bash
DEV=$1
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR/.env"

if [ ! -d $TEMP_DIR ]; then
	mkdir $TEMP_DIR
fi
CACHE_NAMESERVER="$TEMP_DIR/$DEV.nameserver"
echo -n "" > $CACHE_NAMESERVER

dns=dns
for opt in ${!foreign_option_*}
do
	eval "dns=\${$opt#dhcp-option DNS }"
	if [[ $dns =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]]; then
	
		if [ ! -f /etc/resolv.conf.default ]; then
			cp /etc/resolv.conf /etc/resolv.conf.default
		fi

		cat /etc/resolv.conf | grep -v ^# | grep -v ^nameserver > /tmp/resolv.conf
		echo "nameserver $dns" >> /tmp/resolv.conf
		echo $dns >> $CACHE_NAMESERVER
		cat /etc/resolv.conf | grep -v ^# | grep -v "nameserver $dns" | grep nameserver >> /tmp/resolv.conf
		mv /tmp/resolv.conf /etc/resolv.conf
		
	fi
done
