#!/usr/bin/env bash

# clears old temp files
# the pdf service leaks files from a few places, it's not practical to properly fix it

while true
do
    sleep 300
    find /tmp -maxdepth 1 -type f -mmin +5 -print -delete 2>&1 >> /app/log/file-cleanup.log
done
