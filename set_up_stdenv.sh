#!/bin/bash
#
# This script sets up my login environment.
#
# The standard environment requires the following directory structure
# under the home directory on any given host:
#
#  ~  (home directory on a given host)
#  |
#  +-- top  <-- ~/top
#      |
#      +-- stdenv
#      |   |
#      |   +-- env
#      |   |
#      |   +-- tools 
#      |   |
#      |   +-- hostenv
#      |       |
#      |       +-- $(uname -n)_stdenv.sh
#      |       |
#      |       +-- $(uname -n)_env.sh
#      |
#      +-- projects
#    
# Host-specific configuration is specified using script
# ../stdenv/hostenv/hostenv_$(uname -n).sh.
#
# It is expected by this script that the following environment
# variables are set properly:
#
#    VictorDir - provides a path to the directory containing
#                all of my files
#
#    DropboxDir - if exists, provides a path to the root of the
#                 directory tree replicated by Dropbox. If it
#                 does not exist, then Dropbox is not used for
#                 replication.
#

# Require basic directory structure:
#
#    ~/top and ~/stdenv

#-------------------------------------------------------------------------------
# Validate prerequisites to building the standard environment
#-------------------------------------------------------------------------------

function error_exit()
{
    local dir=$1
    
    echo "$dir does not exist. You must first either copy it" 1>&2
    echo "and all of its subdirectories to the home directory:" 1>&2
    echo "   cp -r <$(basename $dir)> $dir" 1>&2
    echo "or create a symbolic link to it in the home directory:" 1>&2
    echo "   ln -s <$(basename $dir)> $dir" 1>&2
    exit 1
}

if [[ ! -d ~/top ]]; then error_exit ~/top; fi

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

. ~/top/stdenv/env_helpers.sh

_env_trace ${BASH_SOURCE[0]} "...Starting"

# Create symlinks for env and tools directory to ensure that they are always at a known path

echo "Running ~/top/stdenv/$(basename $0)"

SAVE_DIR=~/.orig

# Host-specific stdenv configuration

HOSTSTDENV=~/top/stdenv/hostenv/$(uname -n)_stdenv.sh

if [[ -f $HOSTSTDENV ]]; then 
    . $HOSTSTDENV
fi

# First time save the standard files. These files should NOT
# be cleaned up by the cleaning script.

if [[ ! -d $SAVE_DIR ]]; then
    create_dir $SAVE_DIR
    safemove_file ~/.bashrc ${SAVE_DIR}/.bashrc
    remove_file ~/.bashrc
    safemove_file ~/.profile ${SAVE_DIR}/.profile
    remove_file ~/.profile
    safemove_file ~/.bash_logout ${SAVE_DIR}/.bash_logout
    remove_file ~/.bash_logout

    safemove_file ~/.emacs ${SAVE_DIR}/.emacs
    remove_file ~/.emacs
    safemove_file ~/.exrc ${SAVE_DIR}/.exrc
    remove_file ~/.exrc
    safemove_file ~/.gitconfig ${SAVE_DIR}/.gitconfig
    remove_file ~/.gitconfig
    safemove_file ~/.gitignore ${SAVE_DIR}/.gitignore
    remove_file ~/.gitignore
    safemove_file ~/.Xdefaults ${SAVE_DIR}/.Xdefaults
    remove_file ~/.Xdefaults
    safemove_file ~/.Xresources ${SAVE_DIR}/.Xresources
    remove_file ~/.Xresources
fi

create_symlink ~/top/dev/projects ~/projects

# Set up standard environment files

create_symlink ~/top/stdenv/env/bash/.bashrc ~/.bashrc
create_symlink ~/top/stdenv/env/bash/.bash_logout ~/.bash_logout
create_symlink ~/top/stdenv/env/bash/.profile ~/.profile

create_symlink ~/top/stdenv/env/my_emacs ~/.emacs
create_symlink ~/top/stdenv/env/my_exrc ~/.exrc
create_symlink ~/top/stdenv/env/my_gitconfig ~/.gitconfig
create_symlink ~/top/stdenv/env/my_gitignore ~/.gitignore
create_symlink ~/top/stdenv/env/my_Xdefaults ~/.Xdefaults
create_symlink ~/top/stdenv/env/my_Xresources ~/.Xresources

# Some files must be copied if they are directly linked to the host OS
# because the host OS may not allow certain necessary file operations
# such as chmod.

case $SYNC_STYLE in
    copy)
        copy_file ~/top/stdenv/env/my_global_gitconfig ~/.gitconfig
        ;;
    shared_folder|symlink|*)
        create_symlink ~/top/stdenv/env/my_global_gitconfig ~/.gitconfig
        ;;
esac

_env_trace ${BASH_SOURCE[0]} "..,Ending"
