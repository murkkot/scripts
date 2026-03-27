#!/usr/bin/env bash

TMP_DIR=$1
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

docker exec -t linkding python manage.py full_backup /etc/linkding/data/backup.zip
if [ $? -ne 0 ]; then
  echo "Backup creation failed" >&2
  exit 1
fi

docker cp linkding:/etc/linkding/data/backup.zip $TMP_DIR/$TIMESTAMP.zip
if [ $? -ne 0 ]; then
  echo "Backup copying to $TMP_DIR failed" >&2
  exit 1
fi

echo "$TMP_DIR/$TIMESTAMP.zip"