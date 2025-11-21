#!/usr/bin/env bash

rm /mnt/hdd/cloud/tmp/clips/t.empty
mv -f /mnt/hdd/cloud/tmp/clips/* /mnt/hdd/various/vids/
touch /mnt/hdd/cloud/tmp/clips/t.empty
rm /mnt/hdd/cloud/tmp/photos/t.empty
mv -f /mnt/hdd/cloud/tmp/photos/* /mnt/hdd/various/photos/
touch /mnt/hdd/cloud/tmp/photos/t.empty
