#!/bin/bash

_env_trace ${BASH_SOURCE[0]} "Starting..."

. ~/top/stdenv/env_helpers.sh

determine_host_type

. ~/top/stdenv/env/my_aliases.sh

set -o emacs

setup_host_environment shellrc

_env_trace ${BASH_SOURCE[0]} "...Ending"
