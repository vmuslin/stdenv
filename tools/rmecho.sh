#!/bin/bash
for file in $*
do
	echo "rm -f $file"
	rm -f $file 2> /dev/null
done
