#!/bin/ksh

. ~/tools/my_funcs.ksh

echo "----- Cleaning up data/incoming -----"
rmecho $SANDBOX/data/incoming/*
echo "----- Cleaning up data/log -----"
rmecho $SANDBOX/data/log/*
echo "----- Cleaning up data/lookup -----"
rmecho $SANDBOX/data/lookup/*
echo "----- Cleaning up data/main -----"
rmecho $SANDBOX/data/main/*
echo "----- Cleaning up data/reject -----"
rmecho $SANDBOX/data/reject/*
