#!/bin/ksh

. $PROJECT_DIR/tools/air_funcs.ksh

project="/Projects/ent/hcm_payroll"
path="$project/scripts"

for f in $KJOB_FILES
do
	air_lock $path $f
done

air lock show -project $project
