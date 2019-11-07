#!/bin/bash

#--------------------------------------------------------------------------------
# __trace
#--------------------------------------------------------------------------------
function __trace
{
    local __prog=$1; shift
    echo "$(date) : [$$]<$__prog> $*"
}

#--------------------------------------------------------------------------------
# _env_trace progname [print_args]
#--------------------------------------------------------------------------------
function _env_trace
{
    if [[ -n "$__ENV_DEBUG" ]]; then
	if [[ -n "$__ENV_TRACE_FILE" ]]
	then
	    __trace $* >> $__ENV_TRACE_FILE
	else
	    __trace $*
	fi
    fi
}
