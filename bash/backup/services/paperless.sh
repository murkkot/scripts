#!/usr/bin/env bash

TMP_DIR=$(docker inspect paperless-webserver | \
 jq -r '.[].Mounts[] | select(.Destination | contains("export")) | .Source')
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

docker exec paperless-webserver document_exporter \
  --delete \
  --zip \
  --zip-name "$TIMESTAMP" \
  --no-progress-bar \
  ../export >/dev/null

if [ $? -ne 0 ]; then
  echo "Backup creation failed" >&2
  exit 1
fi

echo "$TMP_DIR/$TIMESTAMP.zip"