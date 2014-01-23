#!/bin/bash

wldev=`iw dev | grep "face" | sed 's/.* //g'`

if [[ ! -d /etc/netctl || ! `compgen -c | egrep "^iw$"` ]]; then
	echo "Are you sure you have netctl and/or iw installed?"; exit
fi

profiles=`ls /etc/netctl | grep $wldev`; c=1
echo

for i in `ls /etc/netctl | grep $wldev`; do
	echo [$c]  $i
	profile_arr[c]=$i
	c=`expr $c + 1`
done

echo
read -p "Choose a network profile: " choice

if [[ `echo $choice | grep -E "^[0-9]{,}$"` -eq "" ]]; then
	exit
fi

if [[ $choice -lt c ]]; then
	sudo ip link set $wldev down
	sudo netctl stop-all
	sudo netctl start ${profile_arr[$choice]}
fi
