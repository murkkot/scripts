#!/bin/bash

DOW=$(date +%A)

ERROR_OUTPUT1=$(cat /mnt/ssdpci/docker/kopia-localrep/logs/cli-logs/test.log | grep ERROR | grep -v null | awk '{print $1" "$2" "$3" "$4" "$5}')
 
ERROR_OUTPUT2=$(cat /mnt/ssdpci/docker/kopia-localrep/logs/content-logs/test.log | grep error | grep -v null | awk '{print $1" "$2" "$3" "$4" "$5}')
 
 if [ "$ERROR_OUTPUT1" != "" ] || [ "$ERROR_OUTPUT2" != "" ];

 then
	echo "ERROR; VAR NOT EMPTY"
	echo $ERROR_OUTPUT1
	echo $ERROR_OUTPUT2
else
	if [ "$DOW" = "Saturday" ];
	then
		echo "NO ERROR; VAR EMPTY"
		curl -s --form-string "token=$PUSHOVER_TOKEN" --form-string "user=$PUSHOVER_USER_KEY" --form-string "message=$1 BACKUP: $KOPIA_SOURCE_PATH $ERROR_OUTPUT1 $ERROR_OUTPUT2" https://api.pushover.net/1/messages.json
	fi
fi
