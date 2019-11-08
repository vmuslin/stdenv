#!/bin/bash

#
__ENV_DEBUG=true
__ENV_TRACE_FILE=~/env_debug.log
#
. ~/top/stdenv/env_helpers.sh

#--- Custom code goes here...

_env_trace ${BASH_SOURCE[0]} "Start sourcing . ~/.orig/.bash_logout..."
. ~/.orig/.bash_logout
_env_trace ${BASH_SOURCE[0]} "...End sourcing . ~/.orig/.bash_logout"
