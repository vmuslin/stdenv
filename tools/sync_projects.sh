#!/bin/bash

default_from=~/projects/
default_to=~/shared/projects

function parse_args()
{
    local args=$*
    PARAMS=""

    while (( "$#" )); do
        case "$1" in
            -h|--help)
                echo "sync_projects.sh [-h|--help] [-f specfile] [from_list] [to]"
                exit 0
                ;;
            --) # end argument parsing
                shift
                break
                ;;
            -*|--*=) # unsupported flags
                echo "Error: Unsupported flag $1" >&2
                exit 1
                ;;
            *) # preserve positional arguments
                PARAMS="$PARAMS $1"
                shift
                ;;
        esac
    done

    # set positional arguments in their proper place
    #eval set -- "$PARAMS"
}

parse_args $*

case $# in
    0)
        echo "rsync -avz --delete $default_from $default_to"
        rsync -avz --delete $default_from $default_to
        ;;
    1)
        echo "Error: only 1 argument is not allowed" >&2
        exit 1
        ;;
    *)
        echo "rsync -avz --delete $*"
        rsync -avz --delete $*
        ;;
esac
