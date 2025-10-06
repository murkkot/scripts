#!/bin/bash

# Input parameters: $1 LOCAL or REMOTE

DOW=$(date +%A)

ERROR_OUTPUT1=$(cat /app/logs/cli-logs/latest.log | grep ERROR | grep -v null | awk '{print $1" "$2" "$3" "$4" "$5}')
 
ERROR_OUTPUT2=$(cat /app/logs/content-logs/latest.log | grep error | grep -v null | awk '{print $1" "$2" "$3" "$4" "$5}')
 
 if [ "$ERROR_OUTPUT1" != "" ] || [ "$ERROR_OUTPUT2" != "" ];

then
	#echo "ERROR; VAR NOT EMPTY"
	curl -s --form-string "token=$PUSHOVER_TOKEN" --form-string "user=$PUSHOVER_USER_KEY" --form-string "message=$1 BACKUP: $KOPIA_SOURCE_PATH $ERROR_OUTPUT1 $ERROR_OUTPUT2" https://api.pushover.net/1/messages.json
else
	if [ "$DOW" = "Monday" ];
	then
		#echo "NO ERROR; VAR EMPTY"
		curl -s --form-string "token=$PUSHOVER_TOKEN" --form-string "user=$PUSHOVER_USER-KEY" --form-string "message=$1 BACKUP: $KOPIA_SOURCE_PATH $ERROR_OUTPUT1 $ERROR_OUTPUT2" https://api.pushover.net/1/messages.json
	fi
fi
