]#!/bin/ksh

__abuser=${1:-"victor"}
. ~/env/environment_setup_funcs.ksh
SETUP_ABINITIO_PROJECT=true
case $__abuser in
  ben)  export DEFAULT_ABINITIO_SANDBOX="/ab/sand/users/vmuslin/sandboxes/ams_bs" ;;
  greg) export DEFAULT_ABINITIO_SANDBOX="/ab/sand/users/vmuslin/sandboxes/ams_gg" ;;
  jason) export DEFAULT_ABINITIO_SANDBOX="/ab/sand/users/vmuslin/sandboxes/ams_jj" ;;
  dan) export DEFAULT_ABINITIO_SANDBOX="/ab/sand/users/vmuslin/sandboxes/ams_df" ;;
esac
setup_abinitio_project
unset __abuser
