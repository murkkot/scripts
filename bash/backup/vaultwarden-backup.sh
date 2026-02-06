#!/usr/bin/env bash

# current date
current_date=$(date +"%Y-%m-%d %H:%M:%S")
# date for archive name
archive_name=$(date +"%Y%m%d_%H%M%S_backup.tar.gz")
# backup path
backup_path="$1"
# number of archives
archives_num=3

printf '%s ============= Backup job started ===========\n' "$current_date"

if [ $# -ne 1 ]; then
    printf 'Wrong parameters. Usage: %s [BACKUP_PATH]\n' "${0##*/}" >&2
    exit 2
fi

if [ ! -d "$backup_path" ]; then
    printf "ERROR Backup dir doesn't exists\n" >&2
    exit 2
fi

printf 'Stopping docker container\n'
docker stop vaultwarden > /dev/null
printf 'Creating archive %s\n' "$backup_path/$archive_name"
tar -czf "$backup_path"/"$archive_name" -C /home/nas/docker/vaultwarden data
printf 'Starting docker container\n'
docker start vaultwarden > /dev/null

# check exit status
exit_code=$?
if [ $exit_code -ne 0 ]; then
    printf 'ERROR Backup failed\n' >&2
    exit $exit_code
else
    printf 'Backup successful\n'
fi

# count number of *.zip file in backup dir
current_archive_num=$(ls "$backup_path"/*backup.tar.gz 2>/dev/null | wc -l)

if [ $current_archive_num -gt $archives_num ]; then
    oldest_archive=$(ls $backup_path/*backup.tar.gz | head -n 1)
    rm $oldest_archive
    echo "Removed file $oldest_archive"
fi
