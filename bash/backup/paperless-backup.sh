#!/bin/bash

# current date
current_date=$(date +"%Y-%m-%d %H:%M:%S")

docker exec paperless-webserver document_exporter --delete --zip --no-progress-bar ../export

# check exit status
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "$current_date Backup failed"
    exit $exit_code
else
    echo "$current_date Backup successful"
fi
