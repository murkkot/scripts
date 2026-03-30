#!/usr/bin/env bash

TMP_DIR=$1
SOURCE_DIR=$(docker inspect vaultwarden | \
 jq -r '.[].Config.Labels["com.docker.compose.project.working_dir"]')
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Stop docker 
docker stop vaultwarden > /dev/null
if [ $? -ne 0 ]; then
  echo "Couldn't stop docker container" >&2
  exit 1
fi

tar -czf "$TMP_DIR"/"$TIMESTAMP.tar.gz" -C "$SOURCE_DIR" data
if [ $? -ne 0 ]; then
  echo "Backup creation failed" >&2
  exit 1
fi

docker start vaultwarden > /dev/null
if [ $? -ne 0 ]; then
  echo "Couldn't start docker container" >&2
  exit 1
fi

echo "$TMP_DIR/$TIMESTAMP.tar.gz"