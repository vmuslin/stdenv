. ~/tools/my_funcs.ksh

if (( $# < 1 )); then
  echo "Run Id must be specified"
else
  rm_run_files $1
  
  shift
  
  for arg in $@
  do
    if [[ "$arg" = "log" ]]; then
      echo "Removing from \$AI_SERIAL_LOG:"
      for f in $(find $AI_SERIAL_LOG -name "*.log")
      do
        echo "   $f"
      done
      find $AI_SERIAL_LOG -name "*.log" | xargs rm -f
    fi
    
    if [[ "$arg" = "err" ]]; then
      echo "Removing from \$AI_SERIAL_ERROR:"
      for f in $(find $AI_SERIAL_ERROR -name "*.err")
      do
        echo "   $f"
      done
      find $AI_SERIAL_ERROR -name "*.err" | xargs rm -f
    fi
  done
fi
