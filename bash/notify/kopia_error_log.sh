#!/bin/bash

ERROR_LOG_PATH="/mnt/ssdpci/docker/kopia-remoterep/logs/cli-logs"

today=$(date +%Y-%m-%d)
# Find all lines with today's date and ERROR in latest.log
errors=$(awk -v today="$today" 'split($1,prefix,"T") && prefix[1]==today && $2 == "ERROR"' $ERROR_LOG_PATH/latest.log)
# Find all lines with today's date in error.log
today_errors=$(grep "$today" $ERROR_LOG_PATH/error.log)

if [ -n "$errors" ]; then
    if [ -n "$today_errors" ]; then
        echo $errors >> $ERROR_LOG_PATH/error.log
    else
        echo "==================================== $today ====================================" >> $ERROR_LOG_PATH/error.log 
        echo $errors >> $ERROR_LOG_PATH/error.log
    fi
    # TODO notify with pushover
fi

cat $ERROR_LOG_PATH/error.log