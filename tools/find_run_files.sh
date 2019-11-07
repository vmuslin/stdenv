#!/bin/bash

. ~/tools/my_funcs.sh

if (( $# < 1 )); then
  echo "Run Id must be specified"
else
  RUN_ID=$1
  shift
  
  for arg in $@
  do
    if [[ "$arg" = "log" ]]; then
      echo "---------- \$AI_SERIAL_LOG ($AI_SERIAL_LOG) ----------"
      find $AI_SERIAL_LOG
    fi

    if [[ "$arg" = "err" ]]; then
      echo "---------- \$AI_SERIAL_ERROR ($AI_SERIAL_ERROR) ----------"
      find $AI_SERIAL_ERROR
    fi
  done
  
  RUN_FILES=$(find_run_files $RUN_ID | wc -l)
  echo "---------- $RUN_FILES Files for run $RUN_ID ----------"

  find_run_files $RUN_ID
fi