#!/usr/bin/env bash

# archive
rsync -a --info=progress2 /mnt/hdd/archive /mnt/newserver/archive
# photos
mkdir /mnt/newserver/photos/immich
#media
mkdir /mnt/newserver/media/downloads
rsync -a --info=progress2 /mnt/hdd/downloads /mnt/newserver/media/downloads
mkdir /mnt/newserver/media/audiobooks
rsync -a --info=progress2 /mnt/hdd/audiobooks /mnt/newserver/media/audiobooks
mkdir /mnt/newserver/media/music
rsync -a --info=progress2 /mnt/hdd/music /mnt/newserver/media/music
# backup
rsync -a --info=progress2 /mnt/backup /mnt/newserver/backup