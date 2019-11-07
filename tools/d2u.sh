#!/bin/bash

if (( $# >= 1 )); then
  files=$@
fi
for f in $files
do
	dos2unix < "$f" > "${f}xxx" 2> /dev/null
	mv "${f}xxx" "$f"
	echo "$f"
done

