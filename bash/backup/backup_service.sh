#!/usr/bin/env bash

show_help () {
    printf 'USAGE: %s BACKUP_DESTINATION SERVICE_NAME\n
    Arguments:
        BACKUP_DESTINATION      Directory to backup to
        SERVICE_NAME            Service name to call service backup script\n
    Example: %s /mnt/backup paperless\n' "$0" "$0"
}

notify_pushover () {
    	curl -s --form-string "token=$PUSHOVER_TOKEN" \
        --form-string "user=$PUSHOVER_USER_KEY" \
        --form-string "message=$1" \
        https://api.pushover.net/1/messages.json > /dev/null
        printf '\n'
}

BACKUP_DESTINATION=$1
SERVICE_NAME=$2
TMP_DIR=/tmp
SERVICE_BACKUP_SCRIPT_NAME="./services/$SERVICE_NAME.sh"
ROTATE_BACKUPS_SCRIPT_NAME="./rotate_backups.sh"

echo -e "\n============ $(date +"%Y-%m-%d %H:%M:%S") Backup job ============"

# INPUT VALIDATION

if [ $# -lt 2 ]; then
  show_help
  notify_pushover "$0 ERROR: Not enough arguments"
  exit 1
fi

if [ ! -d "$BACKUP_DESTINATION" ]; then
  echo "Backup destination doesn't exist: $BACKUP_DESTINATION" >&2
  notify_pushover "$0 ERROR: Backup destination doesn't exist"
  exit 1
elif [ ! -w "$BACKUP_DESTINATION" ]; then
  echo "Destination is not writable: $BACKUP_DESTINATION" >&2
  notify_pushover "$0 ERROR: Backup destination is not writable"
  exit 1
fi

if [ ! -d "$TMP_DIR" ]; then
  echo "TMP destination doesn't exist: $TMP_DIR" >&2
  notify_pushover "$0 ERROR: TMP destination doesn't exist"
  exit 1
elif [ ! -w "$TMP_DIR" ]; then
  echo "Destination is not writable: $TMP_DIR" >&2
  notify_pushover "$0 ERROR: TMP destination is not writable"
  exit 1
fi

if [ ! -x "$SERVICE_BACKUP_SCRIPT_NAME" ]; then
  echo "$SERVICE_BACKUP_SCRIPT_NAME is not executable or doesn't exist" >&2
  notify_pushover "$0 ERROR: $SERVICE_BACKUP_SCRIPT_NAME is not executable or doesn't exist"
  exit 1
fi

# Call backup function
archive_name=$("$SERVICE_BACKUP_SCRIPT_NAME" "$TMP_DIR")

if [ $? -ne 0 ]; then
  echo "$SERVICE_BACKUP_SCRIPT_NAME failed" >&2
  notify_pushover "$0 ERROR: $SERVICE_BACKUP_SCRIPT_NAME failed"
  exit 1
fi

if [ ! -f "$archive_name" ]; then
  echo "$archive_name doesn't exist" >&2
  notify_pushover "$0 ERROR: $archive_name doesn't exist"
  exit 1
fi

# Rotate backups
if [ ! -f "$ROTATE_BACKUPS_SCRIPT_NAME" ] || [ ! -x "$ROTATE_BACKUPS_SCRIPT_NAME" ]; then
  echo "$ROTATE_BACKUPS_SCRIPT_NAME is not executable or doesn't exist" >&2
  notify_pushover "$0 ERROR: $ROTATE_BACKUPS_SCRIPT_NAME is not executable or doesn't exist"
  exit 1
fi

# DAILY=1 WEEKLY=1 MONTHLY=1 YEARLY=1
$ROTATE_BACKUPS_SCRIPT_NAME "$archive_name" "$BACKUP_DESTINATION/$SERVICE_NAME" 1 1 1 1

if [ $? -ne 0 ]; then
  echo "$ROTATE_BACKUPS_SCRIPT_NAME failed" >&2
  notify_pushover "$0 ERROR: $ROTATE_BACKUPS_SCRIPT_NAME failed"
  exit 1
fi

echo -e "\n============ Backup job successful ============"


 


