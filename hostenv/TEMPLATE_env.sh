#!/bin/bash

# This is a template of a host-specific environment defining script.
#
# For a given host the name of this file should be:
#
#     $(uname -n)/_env.sh
#
# This script is sourced during login or new shell initialization by
# .bashrc and .profile scripts.

_env_trace ${BACH_SOURCE[0]} "...Starting"

# Here are some of the thibngs are typically done in this script:

export DISPLAY=
export PATH=$PATH:
export PYTHONPATH=$PYTHONPATH:
export ORACLE_HOME=
export MANPATH=
export JAVA_HOME

_env_trace ${BACH_SOURCE[0]} "...Ending"
