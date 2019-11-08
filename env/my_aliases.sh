#!/bin/bash

_env_trace ${BASH_SOURCE[0]} "Starting..."

#--- general
alias cls=clear
alias del="/bin/rm -i"
alias dirsync="rsync -avz --delete"
alias h=history
alias manl="man -M/usr/local/man"
alias od='od -Ax -t x1'
alias purge="purge.sh"
alias sql="sqlplus $DBNAME/$DBPASS@$DBSERVER"
alias sync_projects="sudo ~/tools/sync_projects.sh"
alias use_bash="use_bash.sh"
alias xldb="xldb -bg DarkSlateGray -fg yellow -font 7x13bold"

#alias emacs="emacs -fn 7x14"

#--- ls
alias dir="ls -lF"
alias ls="ls --color -F"
alias lsL="ls -L --color -F"
alias lsl="ls -L --color -F"
alias ll="ls -l --color -F"
alias llL="ls -lL --color -F"
alias lll="ls -lL --color -F"
alias lla="ls -lA --color -F"
alias llaL="ls -lLA --color -F"
alias llal="ls -lLA --color -F"

#--- git
alias gitstate="clear; echo '--- git graph ---'; git graph; echo '--- git status ---'; git status"

#--- terminals
alias xterm1="xterm -fn LucidaSans-Typewriter12 -bg DarkSlateBlue -fg white -cr yellow -sb &"
alias xterm2="xterm -fn LucidaSans-Typewriter12 -bg black -fg white -cr yellow -sb &"

alias rxvt1="rxvt -fn LucidaSans-Typewriter14 -bg black -fg green -cr yellow -sb &"
alias rxvt2="rxvt -bg black -fg green -cr yellow -sb&"
alias rxvt3="rxvt -bg wheat -fg black -cr red -sb&"
alias rxvt4="rxvt -fn 7x14 -bg wheat -fg black -cr red -sb&"

_env_trace ${BASH_SOURCE[0]} "...Ending"
