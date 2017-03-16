#!/bin/bash
NC='\033[0m'
clear
if [ $1 == 'devices' ]; then
	while [ true ]; do
		TERMWIDTH=$(tput cols)
		HEADERLOC1=$(( (TERMWIDTH - 43) / 2 ))
		HEADERLOC2=$(( HEADERLOC1 - 2 ))
		echo -n $(tput rev)
		printf "%-20s %-20s %-${HEADERLOC1}s %-${HEADERLOC1}s" "IP Address" "MAC Address" "Status" "Interface"
		echo -e ${NC}
		ip -4 neighbor | awk '{ print $1,$5,$6,$3 }' | sort -t. -n -k1,1n -k 2,2n -k 3,3n -k 4,4n | xargs printf "%-20s %-20s %-${HEADERLOC1}s %-${HEADERLOC1}s\n"
		echo -en '\e[1;1H'
		sleep 2
		tput reset
	done
fi
if [ $1 == 'activity' ]; then
	while [ true ]; do
		TERMWIDTH=$(tput cols)
		HEADERLOC1=$(( (TERMWIDTH - 34) / 2 ))
		HEADERLOC2=$(( HEADERLOC1 ))
		echo -n $(tput rev)
		printf "%-10s %-10s %-10s %-${HEADERLOC1}s %-${HEADERLOC1}s" "UID" "Process" "PID" "Local Address" "Remote Address"
		echo -e ${NC}
		ss -entp4 | sort -u | grep users | sed 's/((//g' | sed 's/))//g' | sed 's/users:\"//g' | sed 's/\",pid=/\t/g' | sed 's/,fd=/\t/g' | sed 's/timer.*)//g' | sed 's/uid://g' | awk '{ print $9,$6,$7,$4,$5 }' | sort -u | xargs printf "%-10s %-10s %-10s %-${HEADERLOC1}s %-${HEADERLOC2}s\n"
		echo -en '\e[1;1H'
		sleep 2
		tput reset
	done
fi
exit 0
