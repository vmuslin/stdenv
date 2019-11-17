#!/bin/bash
#
# This script installs software on Linux
#

# Space-separated list of $(uname -o) values
VALID_PLATFORMS="GNU/Linux"

. ~/top/stdenv/env_helpers.sh

#-------------------------------------------------------------------------------
# usage
#-------------------------------------------------------------------------------

function usage()
{
    script=$(basename $0)

    if (( $# > 0 )); then echo_to_stderr "Error: $*"; fi
    echo_to_stderr "$script [-f|--flavor [aws|windows] [-h|--help|-?]"
    exit 1
}

#-------------------------------------------------------------------------------
# parse_cmd_args
#-------------------------------------------------------------------------------

function parse_cmd_args()
{
    PARAMS=""

    while (( "$#" ))
    do
        case "$1" in
            -f|--flavor) # define flavor (default = $(uname -o))
                FLAVOR=$2
                shift 2
                ;;
            -h|--help|-?) # help
                usage
                ;;
            --) # end argument parsing
                shift
                break
                ;;
            -*|--*=) # unsupported flags
                usage "Unsupported flag $1"
                ;;
            *) # preserve positional arguments
                PARAMS="$PARAMS $1"
                shift
                ;;
        esac
    done

    # set positional argumen
    eval set -- "$PARAMS"
}

#-------------------------------------------------------------------------------
# validate_platform_and_flavor
#-------------------------------------------------------------------------------

function validate_platform_and_flavor()
{
    PLATFORM=$(uname -o)

    for p in "$VALID_PLATFORMS"
    do

        if [[ "$PLATFORM" != "$p" ]]
        then
            usage "Invalid platform: $PLATFORM; supported platform(s): $VALID_PLATFORMS"
        fi
    done
    
    case "$FLAVOR" in
        aws) ;;
        windows) ;;
        *)
            usage "Invalid flavor: $FLAVOR"
            ;;
    esac
}

#-------------------------------------------------------------------------------
# install_linux_software
#-------------------------------------------------------------------------------

function install_linux_software()
{
    # Upgrade the installation:
    prompt_command "sudo apt update"
    prompt_command "sudo apt upgrade"

    # Install Ubuntu software
    prompt_command "sudo apt install tree"

    case "$FLAVOR" in
        aws-ubuntu)
            prompt_command "sudo apt install emacs25"
            ;;
        windows-ubuntu)
            prompt_command "sudo add-apt-repository ppa:kelleyk/emacs"
            prompt_command "sudo apt update"
            prompt_command "sudo apt install emacs26"
            ;;
    esac

    # Upgrade to the newer Windows 10
    # Install terminal programs
    prompt_command "sudo apt install xterm"
    prompt_command "sudo apt install rxvt-unicode"
    prompt_command "sudo apt install gnome-terminal"

    # Fonts
    prompt_command "sudo apt install gnome-font-viewer"

    # Traceroute
    prompt_command "sudo apt install inetutils-traceroute"

    # SQLite
    prompt_command "sudo apt install sqlite3"

    # M4
    prompt_command "sudo apt install m4"

    # Python
    prompt_command "sudo apt-get install --fix-missing python3-venv"
    prompt_command "sudo apt install --fix-missing python-pip"
    prompt_command "sudo apt install --fix-missing python3-pip"
}

#-------------------------------------------------------------------------------
# install_python_packages
#-------------------------------------------------------------------------------

function install_python_packages()
{
    for package in $*
    do
        prompt_command "pip3 install $package"
    done
}


#-------------------------------------------------------------------------------
#
# Main Script
#
#-------------------------------------------------------------------------------

. $(dirname $0)/env_helpers.sh

FLAVOR="Unknown"

# Parse command line arguments
parse_cmd_args $*

# Validate the platform
validate_platform_and_flavor

# Install  Linux software
install_linux_software

# Pip Packages
install_python_packages tweepy twython facebook-sdk bottle flask Jinja2
install_python_packages redis Werkzeung pyyaml exifread python-firebase
