#!/usr/bin/env bash

# archive
printf "\narchive\n"
diff -rq /mnt/hdd/archive /mnt/newserver/archive
# cloud
#printf "\ncloud\n"
#diff -rq /mnt/hdd/cloud /mnt/newserver/cloud
# photos
# printf "\nphotos-photos\n"
# diff -rq /mnt/hdd/photos/photo /mnt/newserver/photos/photos
# printf "\nphotos-phone\n"
# diff -rq /mnt/hdd/photos/phone /mnt/newserver/photos/phone
# printf "\nphotos-tmp\n"
# diff -rq /mnt/hdd/photos/tmp /mnt/newserver/photos/tmp
# work
#printf "\nwork\n"
#diff -rq /mnt/hdd/work /mnt/newserver/work
# media
printf "\nmedia-downloads\n"
diff -rq /mnt/hdd/downloads /mnt/newserver/media/downloads
printf "\nmedia-audiobooks\n"
diff -rq /mnt/hdd/audiobooks /mnt/newserver/media/audiobooks
printf "\nmedia-cartoons\n"
diff -rq /mnt/hdd/cartoons /mnt/newserver/media/cartoons
printf "\nmedia-movies\n"
diff -rq /mnt/hdd/movies /mnt/newserver/media/movies
printf "\nmedia-series\n"
diff -rq /mnt/ssdsata/series /mnt/newserver/media/series
printf "\nmedia-music\n"
diff -rq /mnt/hdd/music /mnt/newserver/media/music
# various
printf "\nvarious\n"
diff -rq /mnt/hdd/various /mnt/newserver/various
# backup
printf "\nbackup\n"
diff -rq /mnt/backup /mnt/newserver/backup

