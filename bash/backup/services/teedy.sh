#!/usr/bin/env bash

TMP_DIR=$1
SOURCE_DIR=$(docker inspect teedy | \
 jq -r '.[].Config.Labels["com.docker.compose.project.working_dir"]')
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$TMP_DIR/teedy"
# backup db
docker exec teedy-db pg_dump -U teedy teedy  > "$TMP_DIR/teedy/$TIMESTAMP.sql"
if [ $? -ne 0 ]; then
  echo "DB dump failed" >&2
  exit 1
fi
# backup data
cp -r "$SOURCE_DIR/docs/data/lucene" "$SOURCE_DIR/docs/data/storage" "$TMP_DIR/teedy/"
if [ $? -ne 0 ]; then
  echo "Data backup failed" >&2
  exit 1
fi
# compress data
tar -czf ${TMP_DIR}/$TIMESTAMP.tar.gz -C "$TMP_DIR/teedy" . >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Archive creation failed" >&2
  exit 1
fi
rm -rf "$TMP_DIR/teedy"

echo "$TMP_DIR/$TIMESTAMP.tar.gz"