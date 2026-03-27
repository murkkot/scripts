#!/usr/bin/env bash

TMP_DIR=$1
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

#docker exec paperless-webserver document_exporter --delete --zip --no-progress-bar ../export >/dev/null
docker exec paperless-webserver document_exporter --delete --zip \
  --no-progress-bar ../export/$TIMESTAMP.zip >/dev/null
if [ $? -ne 0 ]; then
  echo "Backup creation failed" >&2
  exit 1
fi

echo "$TMP_DIR/$TIMESTAMP.zip"