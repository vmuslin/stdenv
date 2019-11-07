#!/bin/bash

#-------------------------------------------------------------------------------
# Environment set up and restore Helper Functions
#-------------------------------------------------------------------------------

#--------------------------------------------------------------------------------
# __trace
#--------------------------------------------------------------------------------
function __trace
{
    local __prog=$1; shift
    echo "$(date) : [$$]<$__prog> $*"
}

#--------------------------------------------------------------------------------
# _env_trace progname [print_args]
#--------------------------------------------------------------------------------
function _env_trace
{
    if [[ -n "$__ENV_DEBUG" ]]; then
	if [[ -n "$__ENV_TRACE_FILE" ]]
	then
	    __trace $* >> $__ENV_TRACE_FILE
	else
	    __trace $*
	fi
    fi
}

#---------------------------------------------------------------------------
# append_shared_library_path
#
# Parameters
#
#    $1 - directory
#---------------------------------------------------------------------------

function append_shared_library_path()
{
  typeset delim=${PATH_DELIM:-:}
  typeset dir=$1
  
  if [[ ! -d $dir && -r $dir ]]; then
    return
  fi
  
  case $ARCH in
    aix4 )  if [ -z "$LIBPATH" ]; then
              LIBPATH=$dir
            else
		LIBPATH=$LIBPATH${delim}:$dir
            fi
            export LIBPATH
            ;;

    sunos5 )  if [ -z "$LD_LIBRARY_PATH" ]; then
                  LD_LIBRARY_PATH=$1
              else
                  LD_LIBRARY_PATH=$LD_LIBRARY_PATH${delim}$1
              fi
              export LD_LIBRARY_PATH
              ;;
  esac
}

#---------------------------------------------------------------------------
# copy_dir
#---------------------------------------------------------------------------

function copy_dir() # copy_dir from to
{
    local from=$1
    local to=$2

    [[ -e $to ]] && rm -rf $to

    if [[ -d $from ]]
    then
	      cp -r $from $to
	      echo "Copied $from to $to"
	      return 0
    fi
    return 1
}

#---------------------------------------------------------------------------
# copy_file
#---------------------------------------------------------------------------

function copy_file() # copy_file from to
{
    local from=$1
    local to=$2
    
    [[ -e $to ]] && rm -f $to

    if [[ -f $from ]]
    then
	      cp $from $to
	      echo "Copied $from to $to"
        return 0
    fi
    return 1
}    

#---------------------------------------------------------------------------
# create_dir
#---------------------------------------------------------------------------

function create_dir() # create_dir dir
{
    local dir=$1

    [[ -e $dir ]] && rm -rf $dir

    if [[ ! -d "$dir" ]]
    then
	      mkdir -p $dir
	      echo "Created dictory $dir"
        return 0
    fi
    return 1
}

#---------------------------------------------------------------------------
# create_synmlink
#---------------------------------------------------------------------------

function create_symlink() # create_symlink target link
{
    local target=$1
    local link=$2

    if [[ -d $target || -f $target || -L $target ]]
    then
        if [[ ! -d $link && ! -f $link && ! -L $link ]]
        then
	          ln -s $target $link
	          echo "Creatied symlink $link -> $target"
            return 0
        fi
    fi
    return 1
}

#---------------------------------------------------------------------------
# determine_host_type
#---------------------------------------------------------------------------

function determine_host_type()
{
  # If arch script exist, execute it to set up ARCH
  # environmental variable, which indicates the
  # architecture of the machine to be used to
  # interpret binary and object files and libraries
  #

  UNAME=$(which uname)

  if [[ -n "$UNAME" ]]; then
    OS=`$UNAME -s`
    MACHINE=`$UNAME -m`
    local _ARCH="$OS+$MACHINE"
  fi

  case "$_ARCH" in
    AIX)                      ARCH=aix4;         OS=aix4;      PATH_DELIM=":" ;;
    CYGWIN_NT-5.0+i686)       ARCH=cygwin_i686;  OS=cygwin;    PATH_DELIM=":" ;;
    CYGWIN_NT-5.1+i686)       ARCH=cygwin_i686;  OS=cygwin;    PATH_DELIM=":" ;;
    CYGWIN_NT-6.1-WOW64+i686) ARCH=cygwin_i686;  OS=cygwin;    PATH_DELIM=":" ;;
    Linux+i686)               ARCH=linux_i686;   OS=linux;     PATH_DELIM=":" ;;
    Linux+x86_64)             ARCH=linux_x86_64; OS=linux;     PATH_DELIM=":" ;;
    sun4)                     ARCH=sunos5;       OS=sunos5;    PATH_DELIM=":" ;;
    sunos5)                   ARCH=sunos5;       OS=sunos5;    PATH_DELIM=":" ;;
    SunOS)                    ARCH=sunos5;       OS=sunos;     PATH_DELIM=":" ;;
    SunOS+sun4u)              ARCH=sunos5;       OS=sunos;     PATH_DELIM=":" ;;
    win32)                    ARCH=win32;        OS=win32;     PATH_DELIM=";" ;;
    Windows_95)               ARCH=i686;         OS=mks;       PATH_DELIM=";" ;;
    Windows_NT)               ARCH=i686;         OS=mks;       PATH_DELIM=";" ;;
    *)                        ARCH=unknown;      OS=unknown;   PATH_DELIM=":" ;;
  esac

  export OS
  export MACHINE
  export ARCH
  export PATH_DELIM
}

#---------------------------------------------------------------------------
# echo_to_stderr
#---------------------------------------------------------------------------

function echo_to_stderr()
{
    echo "$@" 1>&2
}

#---------------------------------------------------------------------------
# exists_file_or_symlink
#---------------------------------------------------------------------------

function exists_file_or_symlink() # is_file_or_symlink filename
{
    if [[ -e $1 || -L $1 ]]
    then
        return 0 # true
    else
        return 1 # false
    fi
}

#---------------------------------------------------------------------------
# get_script_dir
#---------------------------------------------------------------------------

function get_script_dir()
{
    local curdir=$(pwd)
    local scriptdir=$(dirname ${BASH_SOURCE[0]})

    cd $scriptdir 
    scriptdir=$(pwd)
    cd $curdir
    echo $scriptdir
}

#---------------------------------------------------------------------------
# init_shared_library_path
#---------------------------------------------------------------------------

function init_shared_library_path()
{
  case $ARCH in
    aix4 )  if [ -z "$_SYSLIBS" ]; then
              if [ -n "$LIBPATH" ]; then
                _SYSLIBS=$LIBPATH
                export _SYSLIBS
              fi
            else
              LIBPATH=$_SYSLIBS
              export LIBPATH
            fi
            ;;

    sunos5 )  if [ -z "$_SYSLIBS" ]; then
                _SYSLIBS="$LD_LIBRARY_PATH"
                export _SYSLIBS
              else
                LD_LIBRARY_PATH=$_SYSLIBS
                export LD_LIBRARY_PATH
              fi
              ;;
  esac
}

#---------------------------------------------------------------------------
# move_dir
#---------------------------------------------------------------------------

function move_dir() # move directory
{
    local from=$1
    local to=$2

    if [[ -d $from ]]
    then
        mv $from $to
        echo "Moved $from to $to"
        return 0
    fi
    return 1
}

#---------------------------------------------------------------------------
# move_file
#---------------------------------------------------------------------------

function move_file() # move_file from to
{
    local from=$1
    local to=$2

    if [[ -d $from || -f $from ]]
    then
	      mv $from $to
	      echo "Moved $from to $to"
        return 0
    fi
    return 1
}    

#---------------------------------------------------------------------------
# osVersion
#---------------------------------------------------------------------------

function osVersion()
{
    echo $(uname -v | cut -d - -f2 | cut -d ' ' -f1)
}

#---------------------------------------------------------------------------
# path_append
#
# Parameters
#
#    $1 - delimiter
#    $2 - directory
#---------------------------------------------------------------------------

function path_append()
{
  typeset delim=$1
  typeset dir=$2
 
  if [[ -d $dir ]]; then
    echo $PATH | tr "$delim" "\n" | egrep "^${dir}$" > /dev/null
    if (( $? != 0 )); then
	      PATH="$PATH${delim}${dir}"
	      export PATH
    fi
  fi
}

#---------------------------------------------------------------------------
# prompt
#---------------------------------------------------------------------------

function prompt()
{
  case $OS in
    mks | win32 | cygwin) echo -n $@ ;;
    sunos) print -n $@ ;;
    *) echo $@ ;;
  esac
}

#---------------------------------------------------------------------------
# prompt_command
#---------------------------------------------------------------------------

function prompt_command()
{
    cmd="$*"

    echo "#--------------------------------------------------"
    echo "#"
    echo "# ${cmd}"
    echo "#"
    echo "#--------------------------------------------------"
    read -p "Enter [Y/n] to continue? " yes

    if [[ "$yes" == "y" || "$yes" == "Y" || "$yes" == "" ]]
    then
        echo "Running: ${cmd}"
        ${cmd}
        return $?
    fi
    return 1          
}

#---------------------------------------------------------------------------
# purge_junk_files
#
# Remove unwanted files
#---------------------------------------------------------------------------

function purge_junk_files()
{
  rm -f ~/smit.log ~/smit.script ~/login.sql ~/.pine-debug*
}

#---------------------------------------------------------------------------
# remove_dir
#---------------------------------------------------------------------------

function remove_dir() # remove_dir directory
{
    local dir=$1

    if [[ -d "$dir" ]]
    then
	      rm -rf $dir
	      echo "Removed $dir"
        return 0
    fi
    return 1
}    

#---------------------------------------------------------------------------
# remnove_file_or_dir
#---------------------------------------------------------------------------

function remove_file_or_dir() # remove_file_or_dir filename|dirname
{
    local item=$1
    if [[ -d $item ]]
    then
        remove_dir $item
        return $?
    elif [[ -f $item || -L $item ]]
    then
        remove_file $item
        return $?
    fi
    return 1
}

#---------------------------------------------------------------------------
# remove_file
#---------------------------------------------------------------------------

function remove_file() # remove_file filename
{
    local file=$1

    if [[ -f $file || -L $file ]]
    then
	      rm $file
	      echo "Removed $file"
        return 0
    fi
    return 1
}

#---------------------------------------------------------------------------
# remove_symlink
#---------------------------------------------------------------------------

function remove_symlink() # just another way to call remove_file
{
    remove_file $*
}

#---------------------------------------------------------------------------
# safecopy_file
#---------------------------------------------------------------------------

function safecopy_file() # safecopy_file from to
{
    local from=$1
    local to=$2

    if [[ ! -e $to && -f $from ]]
    then
	      copy_file $from $to
        return $?
    fi
    return 1
}    

#---------------------------------------------------------------------------
# safecreate_dir
#---------------------------------------------------------------------------

function safecreate_dir() # safecreate_dir dir
{
    local dir=$1

    if [[ ! -d $dir ]]
    then
        create_dir $dir
        return $?
    fi
    return 0
}

#---------------------------------------------------------------------------
# safemove_file
#---------------------------------------------------------------------------

function safemove_file() # safemove_file from to
{
    local from=$1
    local to=$2

    if [[ ! -e $to && -e $from ]]
    then
	      move_file $from $to
        return $?
    fi
    return 1
}

#---------------------------------------------------------------------------
# setup_abinitio
#   Fix the directory separator for the AB_ variables.
#   If AB_HOME is not fixed, then cd will not change the PWD variable.
#---------------------------------------------------------------------------

function setup_abinitio()
{
  if [[ -n $AB_HOME ]]; then
    export AB_HOME=$(echo ${AB_HOME}|sed -e 's/\\/\//g')
  fi
  
  if [[ -n $AB_WORK_DIR ]]; then
    export AB_WORK_DIR=$(echo ${AB_WORK_DIR}|sed -e 's/\\/\//g')
  fi
  
  if [[ -n $AB_AIR_ROOT ]]; then
    export AB_AIR_ROOT=$(echo ${AB_AIR_ROOT}|sed -e 's/\\/\//g')
  fi
}

#---------------------------------------------------------------------------
# setup_abinitio_project
#---------------------------------------------------------------------------

function setup_abinitio_project()
{
  if [[ "$SETUP_ABINITIO_PROJECT" = "true" ]]; then
    export PROJECT=${PROJECT:=$DEFAULT_ABINITIO_PROJECT}
    export SANDBOX=${SANDBOX:=$DEFAULT_ABINITIO_SANDBOX}
    export CDPATH=$CDPATH:$SANDBOX
    export PROJECT_DIR=$SANDBOX
    . $SANDBOX/ab_project_setup.ksh $SANDBOX
  fi
}

#---------------------------------------------------------------------------
# setup_env
#---------------------------------------------------------------------------

function setup_env()
{
  shell=$1

  if [[ "$shell" = "-bash" ]]; then
      ENV=~/.bashrc; export ENV
      BASH_ENV=~/.bashrc; export BASH_ENV
  else
      case $(basename $shell) in
	  bash) ENV=~/.bashrc; export ENV
              BASH_ENV=~/.bashrc; export BASH_ENV
              ;;
  
	  ksh)  ENV=~/.shrc; export ENV
              ;;
      esac
  fi
}

#---------------------------------------------------------------------------
# setup_environment_variables
#---------------------------------------------------------------------------

function setup_environment_variables()
{
  HOSTNAME=$(uname -n); export HOSTNAME
  
  case $OS in
      linux | mks | win32 | cygwin) EDITOR=emacs; export EDITOR
                                    FCEDIT=emacs; export FCEDIT
                                    MANPATH=~/man:/usr/local/man:/usr/share/man:/usr/man; export MANPATH
                                    if [[ -x $(which less) ]]; then
                                        PAGER=$(which less); export PAGER
                                    elif [[ -x $(which more) ]]; then
                                        PAGER=$(which more); export PAGER
                                    fi
                                    VISUAL=emacs; export VISUAL
                                    ;;
      *) ;;
  esac
  
  ENSCRIPT="-G -2r -f Courier7"; export ENSCRIPT
  LS_COLORS='no=00;36:fi=00;36:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=31:*.tar=34:*.tgz=34:*.arj=34:*.taz=34:*.lzh=34:*.zip=34:*.z=34:*.Z=34:*.gz=34:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.html=01;33:*.shtml=33:*.phtml=33:*.sql=01;32:*.log=33;44:*.out=44;01;33:*.cpp=33:*.hpp=33:*.h=33:*.c=33:*.cf=35:*akefile=01;33:'; export LS_COLORS
  LS_COLORS='di=01;31:'; export LS_COLORS
  LS_OPTIONS='--color=tty'; export LS_OPTIONS
}

#---------------------------------------------------------------------------
# setup_history_file
#---------------------------------------------------------------------------

function setup_history_file()
{
  HISTFILE=~/.history/.${HOSTNAME}_${USER}_$$_history; export HISTFILE
  HISTSIZE=1000; export HISTSIZE
}

#---------------------------------------------------------------------------
# setup_host_environment
#
# Setup host-specific environment, if any
# NOTE: The order of file execution is lexicographical
#       based on the filename. Therefore, please be careful
#       when naming files in $ENVIRON/hosts/* directories.
#
# Parameters
#
#    $1 - prefix
#---------------------------------------------------------------------------

function setup_host_environment()
{
    HOSTENV=~/stdenv/hostenv/$(uname -n)_env.sh

    if [[ -f $HOSTENV ]]; then
	      _env_trace ${BASH_SOURCE[0]} "Start sourcing $HOSTENV..."
        . $HOSTENV
	      _env_trace ${BASH_SOURCE[0]} "...End sourcing $HOSTENV"	  
    fi
}

#---------------------------------------------------------------------------
# setup_git_environment
#---------------------------------------------------------------------------

function setup_git_environment()
{
    GIT_EDITOR=emacs; export GIT_EDITOR
    GIT_AUTHOR_NAME="Victor Muslin"; export GIT_AUTHOR_NAME
    GIT_AUTHOR_EMAIL="vm202@columbia.edu"; export GIT_AUTHOR_EMAIL
}

#---------------------------------------------------------------------------
# setup_mail_notification
#---------------------------------------------------------------------------

function setup_mail_notification()
{
  case $OS in
      linux | win32 | cygwin | mks | unknown) ;;
      *)  if [[ -s "$MAIL" && "$OS" != "sunos" ]]; then
              frm
          fi
          if [ -r '/bin/biff' ]; then
              biff y 2> /dev/null	# ignore errors
          fi
          ;;
  esac
}

#---------------------------------------------------------------------------
# setup_path
#---------------------------------------------------------------------------

function setup_path()
{
  # System directories
  path_append $PATH_DELIM /bin
  path_append $PATH_DELIM /usr/bin
  path_append $PATH_DELIM /usr/local/bin
  path_append $PATH_DELIM /sbin
  path_append $PATH_DELIM /usr/sbin
  path_append $PATH_DELIM /usr/ucb
  path_append $PATH_DELIM /usr/bin/X11

  # Openwin programs
  if [[ "$OS" = "sunos" ]]; then
    path_append $PATH_DELIM /usr/openwin/bin
    path_append $PATH_DELIM /opt/SUNWspro/bin
    path_append $PATH_DELIM /usr/ccs/bin
  fi

  # Ab Initio
  path_append $PATH_DELIM $AB_HOME/bin
  
  # My directories
  path_append $PATH_DELIM ~/top/stdenv/env
  path_append $PATH_DELIM ~/top/stdenv/tools
  path_append $PATH_DELIM ~/bin
}

#---------------------------------------------------------------------------
# setup_prompt
#---------------------------------------------------------------------------

function setup_prompt()
{
    export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
#    export PS1="${USER} [ ${HOSTNAME}:\${PWD} ] !
#\$ "
}

#---------------------------------------------------------------------------
# setup_shared_library_path
#---------------------------------------------------------------------------

function setup_shared_library_path()
{
  case $OS in
    aix4 | linux | sunos)
      append_shared_library_path /usr/local/lib
      append_shared_library_path /usr/local/openwin
      append_shared_library_path /usr/openwin/lib
      ;;
  esac
}

#---------------------------------------------------------------------------
# setup_shell_environment
#---------------------------------------------------------------------------

function setup_shell_environment()
{
  umask 022
#
  case $OS in
      mks | win32 | cygwin) ;;
      linux) ;; #stty -ixon erase  kill ^U susp ^Z intr ^C eof ^D ;;
      *) stty -ixon erase  kill ^U susp ^Z intr ^C eof ^D ;;
  esac
}

#---------------------------------------------------------------------------
# setup_user
#---------------------------------------------------------------------------

function setup_user()
{
  if [[ -z "$USER" ]]; then
    case $OS in
      mks)  USER=$LOGNAME
            export USER
            ;;
      *)  USER=$(who am i | tr '@' ' ' | awk '{ print $1 }')
          export USER
          ;;
    esac
  fi
}

#---------------------------------------------------------------------------
# source_host_environment
#
# Setup host-specific environment, if any
#
# Parameters
#
#    $1 - host config script
#---------------------------------------------------------------------------

function source_host_environment()
{
    local hscript=$1
    
    if [[ -f $hscript && -r $hscript && -x $hscript ]]
    then
        . $hscript
    fi
}
