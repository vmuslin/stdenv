#!/bin/bash

. $(dirname $0)/env_helpers.sh

echo "Running $(get_script_dir)/$(basename $0)"

SAVE_DIR=~/.orig

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

copy_file ${SAVE_DIR}/.bashrc ~/.bashrc
copy_file ${SAVE_DIR}/.bash_logout ~/.bash_logout
copy_file ${SAVE_DIR}/.profile ~/.profile

copy_file ${SAVE_DIR}/.emacs ~/.emacs
copy_file ${SAVE_DIR}/.exrc ~/.exrc
copy_file ${SAVE_DIR}/.gitconfig ~/.gitconfig
copy_file ${SAVE_DIR}/.gitignore ~/.gitignore
copy_file ${SAVE_DIR}/.Xdefaults ~/.Xdefaults
copy_file ${SAVE_DIR}/.Xresources ~/.Xresources

remove_file_or_dir $SAVE_DIR
remove_file_or_dir ~/projects

prompt_command remove_file_or_dir ~/top
