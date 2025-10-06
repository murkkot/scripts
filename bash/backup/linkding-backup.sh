#!/bin/bash

# number of archives
archives_num=3
# backup dir
backup_dir=/mnt/backup/linkding
# current date
current_date=$(date +"%Y-%m-%d %H:%M:%S")
# filename with dat
filedate=$(date +"%Y-%m-%d")

echo -e "\n============ $current_date Backup job ============"

docker exec -t linkding python manage.py full_backup /etc/linkding/data/backup.zip

# check exit status
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "$current_date Backup failed"
    exit $exit_code
else
    echo "$current_date Backup successful"
fi

# count number of *.zip file in backup dir
current_archive_num=$(ls $backup_dir/*.zip 2>/dev/null | wc -l)

if [ $current_archive_num -ge $archives_num ]; then
    oldest_archive=$(ls $backup_dir/*.zip | head -n 1)
    rm $oldest_archive
    echo "Removed file $oldest_archive"
fi

docker cp linkding:/etc/linkding/data/backup.zip $backup_dir/backup-$filedate.zip

# check exit status
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "$current_date Copying backup archive failed"
    exit $exit_code
else
    echo "$current_date Copying backup archive successful"
fi
