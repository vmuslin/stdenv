#!/bin/bash
interval=$1
host=$2
while true; do
    ping $host > /dev/null; echo -n $?; date +" %s %a %b %d %X %Z %Y" #date +" %s %Y-%m-%d %H:%M:%S"
    sleep $interval
done
