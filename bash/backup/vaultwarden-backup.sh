#!/usr/bin/env bash

# current date
current_date=$(date +"%Y-%m-%d %H:%M:%S")
# backup path
backup_path="$1"
# number of archives
archives_num=3

printf '%s Backup job started\n' "$current_date"

if [ $# -ne 1 ]; then
    printf 'Wrong parameters. Usage: %s [BACKUP PATH]\n' "${0##*/}" >&2
    exit 2
fi

if [ ! -d "$backup_path" ]; then
    printf "ERROR Backup dir doesn't exists\n" >&2
    exit 2
fi

docker run --rm --volumes-from=vaultwarden -e UID=1000 -e BACKUP_DIR=/myBackup -e TIMESTAMP=true -v "$backup_path":/myBackup bruceforce/vaultwarden-backup manual

# check exit status
exit_code=$?
if [ $exit_code -ne 0 ]; then
    printf 'ERROR Backup failed\n' >&2
    exit $exit_code
else
    printf 'Backup successful\n'
fi

# count number of *.zip file in backup dir
current_archive_num=$(ls "$backup_path"/*backup.tar.xz 2>/dev/null | wc -l)

if [ $current_archive_num -ge $archives_num ]; then
    oldest_archive=$(ls $backup_dir/*backup.tar.xz | head -n 1)
    rm $oldest_archive
    echo "Removed file $oldest_archive"
fi