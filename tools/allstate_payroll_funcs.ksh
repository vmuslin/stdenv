#!/bin/ksh
#
# These functions are useful for Allstate Payroll project
#

#---------------------------------------------------------------------------
# find_run_files
#---------------------------------------------------------------------------

function find_run_files
{
  typeset run_id=$1
  
  if [[ -n "$run_id" ]]; then
    find $PAYROLL_LANDING_ZONE -name "*${run_id}*"
    find $AI_SERIAL/.. -name "*${run_id}*"
    find $AI_SERIAL_LOG -name "*${run_id}*"
    find $AI_SERIAL_REPORTS -name "*${run_id}*"
    find $AI_SERIAL_ERROR -name "*${run_id}*"
  else
    echo "Run Id must be specified"
    return 1
  fi
}


#---------------------------------------------------------------------------
# rm_run_files
#---------------------------------------------------------------------------

function rm_run_files
{
  typeset run_id=$1
  
  if [[ -n "$run_id" ]]; then
    typeset list="$(find_run_files $run_id)"
  
    echo "Removing file for Run Id $run_id:"
    for l in $list
    do
      echo "   $l"
    done
    
    rm -rf $list
  else
    echo "Run Id must be specified"
    return 1
  fi
}
