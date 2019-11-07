#!/bin/bash

FILE_PATTERNS="#* .#* *~ .*~ *.bak .*.bak *%backup%* nohup.out"

fp=""
for x in $FILE_PATTERNS
do
    if [[ -z "$fp" ]]
    then
        fp="-name '$x'"
    else
        fp="$fp -or -name '$x'"
    fi
done


if [[ "$1" = "-r" || "$1" = "-R" ]]; then
  recursive=""
else
  recursive="-maxdepth 1"
fi

FIND="find -L . $recursive $fp"

#echo "$FIND"

eval $FIND 2> /dev/null | xargs rmecho.sh
