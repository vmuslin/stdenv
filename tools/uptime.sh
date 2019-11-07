#!/bin/ksh
file=~/uptime.dat
while true
do
	echo "$(date +'%Y-%m-%d-%H-%M-%S') $(uptime)" >> ${file}
	sleep 1
done
