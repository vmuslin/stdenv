#!/bin/bash
# -----------------------------------------------------
# Brandon Rush
# 06/11/93		Version 1.0
#------------------------------------------------------
# Substition script to perform global replacements on
# a list of files or stdin if no files are provided
#
# Return code:
#	0		OK
#	1		XXXsub.temp exists in the current directory
#	2		Invalid files in file list
#	3		Usage error
#
# Arguments:
#	$1		search string
#	$2		substitute string
#	$3		first file name
#	$4 ...  other files
#
# Note:  XXXsub.temp is used as a temporary file
# -----------------------------------------------------

# --------------------------------------
# Make sure we have at least 2 arguments
# --------------------------------------
if [ $# -lt 2 ]
then
	echo Usage:  $0 search_string replace_string file1 ...
	exit 3
fi

if [ -f XXXsub.temp ]
then echo XXXsub.temp is used by substr.
     echo No substitutions made.
     exit 1
fi

# -----------------------------
# search  = search string
# replace = replacement string
# 
# shift out search/replace args
# so that $1, $2, ... are the
# filenames
# -----------------------------
search=$1
replace=$2
shift 2

# ---------------------------------
# make sure all the files are valid
# ---------------------------------
for i in $*
do
	if [ ! -f $i ]
	then
		echo $i is not a file
		exit 2
	fi
done

# -------------------------------------------
# No list of files provided.  Read from stdin
# -------------------------------------------
if [ $# -eq 0 ]
then sed s^"${search}"^"${replace}"^g

# --------------------------------
# List of files provided.  Perform
# substitution on list of files
# remove duplicate filenames
# --------------------------------
else
     ls $* | sort -u | while read file
     do
	     echo $file

	     sed s^"${search}"^"${replace}"^g ${file} > XXXsub.temp

	     if [ $? -eq 0 ]
	     then mv XXXsub.temp ${file}
	     else printf "Error occurred while processing file %s.  " ${file}
              printf "Substitution not made.\n"
	     fi
     done
fi

# Make sure temporary file is gone
if [ "$arch" = "win32" ]; then
        rm -f XXXsub.temp
else
        rm -f XXXsub.temp 2> /dev/null
fi
exit 0
