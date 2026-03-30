#!/usr/bin/env bash

TMP_DIR=$1
SOURCE_DIR=$(docker inspect vikunja | \
 jq -r '.[].Config.Labels["com.docker.compose.project.working_dir"]')
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$TMP_DIR/vikunja"
# backup db
docker exec vikunja_db pg_dump -U vikunja vikunja  > "$TMP_DIR/vikunja/$TIMESTAMP.sql"
if [ $? -ne 0 ]; then
  echo "DB dump failed" >&2
  exit 1
fi

# backup data
tar -C "$SOURCE_DIR" -czf "$TMP_DIR/vikunja/$TIMESTAMP.tar.gz" files >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Data backup failed" >&2
  exit 1
fi

# compress data
tar -czf ${TMP_DIR}/$TIMESTAMP.tar.gz -C "$TMP_DIR/vikunja" . >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Archive creation failed" >&2
  exit 1
fi
rm -rf "$TMP_DIR/vikunja"

echo "$TMP_DIR/$TIMESTAMP.tar.gz"