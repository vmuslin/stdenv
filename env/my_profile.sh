#!/bin/bash

_env_trace ${BASH_SOURCE[0]} "Starting..."

ENV=~/.bashrc; export ENV

. ~/top/stdenv/tools/my_funcs.sh
. ~/top/stdenv/env/my_shrc.sh

export DISPLAY=localhost:0.0
export PYTHONPATH=~/projects/python

determine_host_type
setup_path
setup_shared_library_path
setup_env $SHELL
setup_user
setup_history_file
setup_environment_variables
setup_shell_environment
setup_mail_notification
setup_host_environment profile
setup_host_environment abinitio_before
setup_abinitio
setup_abinitio_project
setup_host_environment abinitio_after
setup_prompt
setup_git_environment
purge_junk_files

_env_trace ${BASH_SOURCE[0]} "...Ending"
