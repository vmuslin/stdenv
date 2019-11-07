#!/bin/bash
#
# Useful functions
#

_env_trace ${BASH_SOURCE[0]} "Starting..."

#---------------------------------------------------------------------------
# timeconv
#---------------------------------------------------------------------------

function timeconv
{
  date -d "1970-01-01 $1 secs UTC"
}

#---------------------------------------------------------------------------
# repeat
#---------------------------------------------------------------------------

function repeat
{
  typeset -i interval=$1
  shift
  
  while true
  do
    eval $*
    if (( interval > 0 )); then
      sleep $interval
    fi
  done
}

_env_trace ${BASH_SOURCE[0]} "...Ending"
