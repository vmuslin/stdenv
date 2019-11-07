#!/bin/bash

. $(dirname $0)/env_helpers.sh

echo "Running $(get_script_dir)/$(basename $0)"

SaveDir=~/.orig

remove_file_or_dir ~/.bashrc
remove_file_or_dir ~/.bash_logout
remove_file_or_dir ~/.profile

remove_file_or_dir ~/.emacs
remove_file_or_dir ~/.exrc
remove_file_or_dir ~/.gitignore
remove_file_or_dir ~/.gitconfig
remove_file_or_dir ~/.Xdefaults
remove_file_or_dir ~/.Xresources

#remove_file_or_dir ~/.ssh

copy_file ${SaveDir}/.bashrc ~/.bashrc
copy_file ${SaveDir}/.bash_logout ~/.bash_logout
copy_file ${SaveDir}/.profile ~/.profile

copy_file ${SaveDir}/.emacs ~/.emacs
copy_file ${SaveDir}/.exrc ~/.exrc
copy_file ${SaveDir}/.gitconfig ~/.gitconfig
copy_file ${SaveDir}/.gitignore ~/.gitignore
copy_file ${SaveDir}/.Xdefaults ~/.Xdefaults
copy_file ${SaveDir}/.Xresources ~/.Xresources

remove_file_or_dir $SaveDir
remove_file_or_dir ~/projects
remove_file_or_dir ~/env
remove_file_or_dir ~/tools
remove_file_or_dir ~/stdenv
remove_file_or_dir ~/victor
