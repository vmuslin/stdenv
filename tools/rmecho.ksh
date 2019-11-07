$!/bin/ksh
for file in $*
do
	echo $file
	rm -f $file 2> /dev/null
done
