#!/usr/bin/env bash

# USAGE: ./rotate_backups.sh SOURCE_FILE DEST [DAILY] [WEEKLY] [MONTHLY] [EARLY]
#
# Arguments:
#   SOURCE_FILE      Source file or directory to backup (required)
#   DEST        Destination directory (required)
#   DAILY       Number of daily backups to keep (default: 7, 0 = unlimited)
#   WEEKLY      Number of weekly backups to keep (default: 4, 0 = unlimited)
#   MONTHLY     Number of monthly backups to keep (default: 12, 0 = unlimited)
#   EARLY       Number of yearly backups to keep (default: 0 = unlimited)
#
# Example:
#   ./rotate_backups.sh /tmp/backup.tar.gz /backup 14 8 24 3

SOURCE_FILE=$1
DEST=$2
DAILY=${3:-7}
WEEKLY=${4:-4}
MONTHLY=${5:-12}
YEARLY=${6:-0}

# INPUT VALIDATION

if [ $# -lt 2 ]; then
  echo "Usage: $0 SOURCE_FILE DEST [DAILY] [WEEKLY] [MONTHLY] [EARLY]" >&2
  exit 1
fi

if [ ! -f "$SOURCE_FILE" ]; then
  echo "Source file doesn't exist: $SOURCE_FILE" >&2
  exit 1
elif [ ! -r "$SOURCE_FILE" ]; then
  echo "Source file is not readable: $SOURCE_FILE" >&2
  exit 1
fi

if [ ! -d "$DEST" ]; then
  echo "Destination doesn't exist: $DEST" >&2
  exit 1
elif [ ! -w "$DEST" ]; then
  echo "Destination is not writable: $DEST" >&2
  exit 1
fi

if [ $# -ge 2 ]; then
  shift 2
  for arg in "$@"; do
    if [[ ! "$arg" =~ ^[0-9]+$ ]]; then
      echo "Error: '$arg' is not a valid number" >&2
      exit 1
    fi
  done
fi

# ARCHIVE NAMING AND COPYING
current_date="$(date +'%Y%m%d_%H%M%S')"
file_extension="${SOURCE_FILE#*.}"  # extract file after first dot

if [ "$(date -u +%d%m)" = "0101" ]; then # 1st day of the year
  filename="${current_date}_yearly.${file_extension}"
elif [ "$(date -u +%d)" = "01" ]; then # 1st day of the month
  filename="${current_date}_monthly.${file_extension}"
elif [ "$(date -u +%u)" = "1" ]; then # 1st day of the week
  filename="${current_date}_weekly.${file_extension}"
else # daily
  filename="${current_date}_daily.${file_extension}"
fi

cp "$SOURCE_FILE" "${DEST}/${filename}"

exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "$current_date Backup failed" >&2
    exit $exit_code
else
    echo -e "$current_date Backup successful\n$SOURCE_FILE copied to ${DEST}/${filename}"
fi

# PURGING
#purge source file
rm "$SOURCE_FILE"

# purge daily backups
num_files=$(find "$DEST" -maxdepth 1 -name "*_daily*" -type f 2>/dev/null | wc -l)
if [ $num_files -gt $DAILY ] && [ $DAILY -gt 0 ]; then
  del_files=$((num_files-DAILY))
  echo "Found $num_files daily files, need to delete $del_files oldest files"
  ls -tr "$DEST"/*_daily* 2>/dev/null | head -n "$del_files" | \
    while IFS= read -r file; do
        echo "Deleting: $file"
        rm -f "$file" 
    done
fi

# purge weekly backups
num_files=$(find "$DEST" -maxdepth 1 -name "*_weekly*" -type f 2>/dev/null | wc -l)
if [ $num_files -gt $WEEKLY ] && [ $WEEKLY -gt 0 ]; then
  del_files=$((num_files-WEEKLY))
  echo "Found $num_files weekly files, need to delete $del_files oldest files"
  ls -tr "$DEST"/*_weekly* 2>/dev/null | head -n "$del_files" | \
    while IFS= read -r file; do
        echo "Deleting: $file"
        rm -f "$file" 
    done
fi

# purge monthly backups
num_files=$(find "$DEST" -maxdepth 1 -name "*_monthly*" -type f 2>/dev/null | wc -l)
if [ $num_files -gt $MONTHLY ] && [ $MONTHLY -gt 0 ]; then
  del_files=$((num_files-MONTHLY))
  echo "Found $num_files monthly files, need to delete $del_files oldest files"
  ls -tr "$DEST"/*_monthly* 2>/dev/null | head -n "$del_files" | \
    while IFS= read -r file; do
        echo "Deleting: $file"
        rm -f "$file" 
    done
fi

# purge yearly backups
num_files=$(find "$DEST" -maxdepth 1 -name "*_yearly*" -type f 2>/dev/null | wc -l)
if [ $num_files -gt $YEARLY ] && [ $YEARLY -gt 0 ]; then
  del_files=$((num_files-YEARLY))
  echo "Found $num_files yearly files, need to delete $del_files oldest files"
  ls -tr "$DEST"/*_yearly* 2>/dev/null | head -n "$del_files" | \
    while IFS= read -r file; do
        echo "Deleting: $file"
        rm -f "$file" 
    done
fi