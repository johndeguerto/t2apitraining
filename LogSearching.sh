#!/bin/bash

## Here we filter by Object.action
tail -f /usr/local/NetSapiens/netsapiens-api/tmp/logs/debug.log | grep "Domains.create" -B20 -A20

## We can search recursivly and display X lines in the current directory
egrep -Ri "Domains.create" -C5 .

## We can search a specific file like so, and display 10 lines before and after
egrep -Ri "Domains.create" -B10 -A10 debug.log

## We can also use a simple regex
egrep -e "Domains.create)|Api|dispatch" debug.log
