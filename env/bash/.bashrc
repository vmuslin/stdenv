#!/bin/bash

__ENV_DEBUG=true
__ENV_TRACE_FILE=~/env_debug.log

. ~/top/stdenv/env_helpers.sh

_env_trace ${BASH_SOURCE[0]} "Starting..."

_env_trace ${BASH_SOURCE[0]} "Start sourcing ~/.orig/.bashrc..."
. ~/.orig/.bashrc
_env_trace ${BASH_SOURCE[0]} "...End sourcing ~/.orig/.bashrc"

. ~/top/stdenv/env/my_shrc.sh

_env_trace ${BASH_SOURCE[0]} "...Ending"
