#!/bin/bash

if [ $# -lt 1 ]
then
    echo "usage:  $0 <sql statement>"
    exit -1
fi

case $DBTYPE in
	SYBASE)
		echo "$*"
		shift
		isql -w150 -Usa -P$DBPASS -e<<EOF
		use $DBUSER
		go
		$*
		go
EOF
		;;

	ORACLE)
		echo "$*"
		sqlplus $DBUSER/$DBPASS@$DBSERVER <<EOF
		alter session set nls_date_format='mm-dd-yyyy hh24:mi:ss';
		set lines 132;
		set pagesize 40;
		$* ;
EOF
		;;
        POSTGRES)
		echo "$*"
		if [ "x$DBSERVER" = "x" ]; then
		    psql -U $DBUSER $DBNAME <<EOF
			$*
EOF
		else
		    psql -U $DBUSER -h $DBSERVER $DBNAME <<EOF
			$*
EOF
		fi
		;;

esac


