#!/user/bin/env bash

# current date
current_date=$(date +"%Y-%m-%d %H:%M:%S")
# backup path
backup_path="$1"

printf '%s Backup job started\n' "$current_date"

if [ $# -ne 1 ]; then
    printf 'Usage: %s [BACKUP PATH]\n' "${0##*/}" >&2
    exit 2
fi

if [ ! -d "$backup_path" ]; then
    printf "Backup dir doesn't exists" >&2
    exit 2
fi

docker run --rm --volumes-from=vaultwarden -e UID=0 -e BACKUP_DIR="$backup_path" -e TIMESTAMP=true -v "$backup_path":/myBackup bruceforce/vaultwarden-backup manual

# check exit status
exit_code=$?
if [ $exit_code -ne 0 ]; then
    printf 'Backup failed' >&2
    exit $exit_code
else
    printf 'Backup successful'
fi