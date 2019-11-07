#!/bin/bash
#
# This script sets up my login environment.
#
# Host-specific configuration is specified using files in
# ../stdenv/hostconfig/$(uname -n) directory. Specifically,
#
# VictorDir - provides a path to the directory containing
#             all of my files
#
# DropboxDir - if exists, provides a path to the root of the
#              directory tree replicated by Dropbox. If it
#              does not exist, then Dropbox is not used for
#              replication.
#

. $(dirname $0)/env_helpers.sh

#-------------------------------------------------------------------------------
#
# Main
#
#-------------------------------------------------------------------------------

# Create symlinks for env and tools directory to ensure that they are always at a known path

scriptdir=$(get_script_dir)
echo "Running ${scriptdir}/$(basename $0)"

SaveDir=~/.orig

# Standard directories

VictorLink=~/victor
StdenvDir=${VictorLink}/stdenv
StdenvLink=~/stdenv
EnvDir=${StdenvLink}/env
EnvLink=~/env
ToolsDir=${StdenvLink}/tools
ToolsLink=~/tools
ProjectsDir=${VictorLink}/dev/projects
ProjectsLink=~/projects

HostConfigDir=${scriptdir}/hostconfig/$(uname -n)
VictorDirFile=${HostConfigDir}/VictorDir
DropboxDirFile=${HostConfigDir}/DropboxDir

# Ensure that we know where Victor's files are...

if [[ ! -f $VictorDirFile ]]
then
    echo_to_stderr "ERROR: file $VictorDirFile does not exist! Exiting..."
    echo_to_stderr "NOTE: Create file ${VictorDirFile}"
    echo_to_stderr "      This file should contain one line that is the name of the directory"
    echo_to_stderr "      of all my files, such as ~/victor"
    exit 1
fi

# First time save the standard files. These files should NOT
# be cleaned up by the cleaning script.

if [[ ! -d $SaveDir ]]
then
    create_dir $SaveDir
    safemove_file ~/.bashrc ${SaveDir}/.bashrc
    remove_file ~/.bashrc
    safemove_file ~/.profile ${SaveDir}/.profile
    remove_file ~/.profile
    safemove_file ~/.bash_logout ${SaveDir}/.bash_logout
    remove_file ~/.bash_logout

    safemove_file ~/.emacs ${SaveDir}/.emacs
    remove_file ~/.emacs
    safemove_file ~/.exrc ${SaveDir}/.exrc
    remove_file ~/.exrc
    safemove_file ~/.gitconfig ${SaveDir}/.gitconfig
    remove_file ~/.gitconfig
    safemove_file ~/.gitignore ${SaveDir}/.gitignore
    remove_file ~/.gitignore
    safemove_file ~/.Xdefaults ${SaveDir}/.Xdefaults
    remove_file ~/.Xdefaults
    safemove_file ~/.Xresources ${SaveDir}/.Xresources
    remove_file ~/.Xresources
fi

# Set up a link to all of my files (typically located in .../victor directory)
#
# Note that the contents of .../stdenv/hostconfig/VictorDir file
# is the path to where all my files are whether they are shared or
# replicated by Dropbox.

VictorDir=$(cat ${HostConfigDir}/VictorDir)
create_symlink $VictorDir $VictorLink

# Set up links for standard paths

create_symlink $StdenvDir $StdenvLink
create_symlink $EnvDir $EnvLink
create_symlink $ToolsDir $ToolsLink
create_symlink $ProjectsDir $ProjectsLink


# Set up standard environment files

create_symlink ${EnvDir}/bash/.bashrc ~/.bashrc
create_symlink ${EnvDir}/bash/.bash_logout ~/.bash_logout
create_symlink ${EnvDir}/bash/.profile ~/.profile

create_symlink ${EnvDir}/my_emacs ~/.emacs
create_symlink ${EnvDir}/my_exrc ~/.exrc
create_symlink ${EnvDir}/my_gitconfig ~/.gitconfig
create_symlink ${EnvDir}/my_gitignore ~/.gitignore
create_symlink ${EnvDir}/my_Xdefaults ~/.Xdefaults
create_symlink ${EnvDir}/my_Xresources ~/.Xresources

#create_symlink ${EnvDir}/.ssh ~/.ssh

# Some files must be copied if they are directly linked to the host OS
# because the host OS may not allow certain necessary file operations
# such as chmod.

if [[ -f $DropboxDirFile ]]
then
    create_symlink ${EnvDir}/my_global_gitconfig ~/.gitconfig
    # create_symlink ${EnvDir}/.ssh ~/.ssh
else
    copy_file ${EnvDir}/my_global_gitconfig ~/.gitconfig
    # remove_symlink ~/.ssh
    # copy_dir ${EnvDir}/.ssh ~/.ssh
fi
