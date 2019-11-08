#!/bin/bash
#
#######################################################################
#
# my_logout.sh
#
#######################################################################

__ENV_DEBUG=true
__ENV_TRACE_FILE=~/env_debug.log
#
. ~/top/stdenv/env/env_helpers.sh
#
_env_trace ${BASH_SOURCE[0]} "Starting..."

#--- Custom code goes here...

_env_trace ${BASH_SOURCE[0]} "Starting..."

unset __ENV_DEBUG
unset __ENV_TRACE_FILE


