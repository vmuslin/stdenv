#!/bin/bash

. $(dirname $0)/env_helpers.sh

prompt_command_with_message 'Note - this is dangerous because
ls -l
is a destructive command!' ls -l
