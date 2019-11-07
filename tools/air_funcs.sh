#!/bin/bash

_env_trace ${BASH_SOURCE[0]} "Starting..."

#---------------------------------------------------------------------------
# air_show_locked
#---------------------------------------------------------------------------
air_show_locked()
{
  project=$1
  echo "-- Command: air lock show -project $project"
  air lock show -project $project
}

#---------------------------------------------------------------------------
# air_lock
#---------------------------------------------------------------------------
air_lock()
{
	typeset USAGE="$0: air_object_path object(s)..."
	
	air_object_path=$1
	
	check_nargs 2 $air_object_path $2
	if (( $? != 0 )); then
		usage_and_exit $? "$USAGE"
	fi
	
	shift
	
	for object in $@
	do
		echo "-- Command: air lock set -object $air_object_path/$object"
		air lock set -object $air_object_path/$object
	done
	
	return 0
}

#---------------------------------------------------------------------------
# air_checkin
#---------------------------------------------------------------------------
air_checkin()
{
	typeset USAGE="$0: project sandbox subdirectory file(s)..."

	project=$1
	sandbox=$2
	sandbox_subdir=$3
	
	check_nargs 4 $sandbox_subdir $project $sandbox $4
	if (( $? != 0 )); then
		usage_and_exit $? "$USAGE"
	fi

	shift 3
	
	for file in $@
	do
		echo "-- Command: air project import $project -basedir $sandbox -files $sandbox_subdir/$file"
		air project import $project -basedir $sandbox -files $sandbox_subdir/$file
	done
	
	return 0
}

#---------------------------------------------------------------------------
# check_nargs
#---------------------------------------------------------------------------
check_nargs()
{
	typeset USAGE="$0: nargs \$\@"
	
	if (( $# < 1 )); then
		usage_and_exit 1 "$USAGE"
	fi
	
	nargs=$1
	
	if (( $# < nargs+1 )); then
		return 2
	fi
	
	return 0
}

#---------------------------------------------------------------------------
# usage_and_exit
#---------------------------------------------------------------------------
usage_and_exit()
{
	rc=$1
	shift
	echo "Usage: $*"
	return $rc
}

_env_trace ${BASH_SOURCE[0]} "...Ending"
