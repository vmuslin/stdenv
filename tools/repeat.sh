#!/bin/bash
#
#
script=$(basename $0)
if [ "$#" -lt 1 ]; then
    echo "usage: repeat seconds [-] command_list"
    exit -1
fi

seconds=$1
shift
dash=$1
if [ "$dash" = "-" ]
then
    dash=true
    shift
else
    dash=false
fi
commands="$*"
echo "$script $seconds $commands"
while (true)
do
    if [ $dash = true ]; then
	echo "-----" `date` "---------------------------------------------------------------------------"
    fi
    eval "$commands"
    sleep $seconds
done
