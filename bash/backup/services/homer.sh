#!/usr/bin/env bash

TMP_DIR=$1
SOURCE_DIR=$(docker inspect homer | \
 jq -r '.[].Config.Labels["com.docker.compose.project.working_dir"]')
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

tar -czf ${TMP_DIR}/$TIMESTAMP.tar.gz -C "$SOURCE_DIR" . >/dev/null 2>&1

echo "$TMP_DIR/$TIMESTAMP.tar.gz"