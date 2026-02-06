#!/usr/bin/env bash

rm /mnt/cloud/tmp/clips/t.empty
mv -f /mnt/cloud/tmp/clips/* /mnt/various/vids/
touch /mnt/cloud/tmp/clips/t.empty
rm /mnt/cloud/tmp/photos/t.empty
mv -f /mnt/cloud/tmp/photos/* /mnt/various/photos/
touch /mnt/cloud/tmp/photos/t.empty