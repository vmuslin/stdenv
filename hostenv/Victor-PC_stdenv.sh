#!/bin/bash

# This is a template of the host-specific stdenv file used to set up
# my starndard environment for a particular host on Unix/Linux.
#
# For a given host the name of this file should be:
#
#     $(uname -n)/_stdenv.sh
#
# This script is typically source by stdenv/set_up_stdenv.sh script
# during the initial environment setup.

_env_trace ${BACH_SOURCE[0]} "...Starting"

# SYNC_STYLE is an optional global environment variable
# that indicates whether the files are by synced across other
# machines due to symlinks (as in Windows/Linux subsystem),
# shared folders (as in Virtual Box) or copied (as in Dropbox).
#
# Acceptable values are:
#
#     symlink (default)
#     shared_folder
#     copy

export SYNC_STYLE=symlink

_env_trace ${BACH_SOURCE[0]} "...Ending"
