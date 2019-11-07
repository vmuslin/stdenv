#!/bin/bash

#-------------------------------------------------------------------------------
# Environment set up and restore Helper Functions
#-------------------------------------------------------------------------------

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

function echo_to_stderr()
{
    echo "$@" 1>&2
}

function exists_file_or_symlink() # is_file_or_symlink filename
{
    if [[ -e $1 || -L $1 ]]
    then
        return 0 # true
    else
        return 1 # false
    fi
}

function get_script_dir()
{
    local curdir=$(pwd)
    local scriptdir=$(dirname ${BASH_SOURCE[0]})

    cd $scriptdir 
    scriptdir=$(pwd)
    cd $curdir
    echo $scriptdir
}

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

function osVersion()
{
    echo $(uname -v | cut -d - -f2 | cut -d ' ' -f1)
}

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

function remove_file_or_dir () # remove_file_or_dir filename|dirname
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

function remove_dir () # remove_dir dirname
{
    local dir=$1

    if [[ -d $dir ]]
    then
        rm -rf $dir
        return 0
    fi
    return 1
}

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

function remove_symlink() # just another way to call remove_file
{
    remove_file $*
}

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
