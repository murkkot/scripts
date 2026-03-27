#!/usr/bin/env bash

TMP_DIR=$1
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$TMP_DIR/wiki"
# backup db
docker exec wiki_postgres pg_dump -U wikijs wiki  > "$TMP_DIR/wiki/$TIMESTAMP.sql"

if [ $? -ne 0 ]; then
  echo "DB dump failed" >&2
  exit 1
fi

# backup data
docker cp wiki:/wiki/backup "$TMP_DIR/wiki" >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Data backup failed" >&2
  exit 1
fi

# compress data
tar -czf ${TMP_DIR}/$TIMESTAMP.tar.gz -C "$TMP_DIR/wiki" . >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Archive creation failed" >&2
  exit 1
fi

rm -rf "$TMP_DIR/wiki"

echo "$TMP_DIR/$TIMESTAMP.tar.gz"