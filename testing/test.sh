#!/bin/bash

. ~/stdenv/tools/testing_funcs.sh
. ~/stdenv/env_helpers.sh

hasDropbox .
echo "Result = $?"
hasDropbox . && echo "Yes" || echo "No"

