#!/bin/bash

# $1 - dataset

dataset="$1"

printf 'Create snapshot'
zfs snapshot -r storage/"$dataset"@rewrite1

stream_size=$(zfs send -n -v -R --raw storage/photos@rewrite1 | grep -oE '[0-9]+G' | tail -n1)
printf 'Estimated stream size: %s' "$stream_size"
zfs send -R --raw storage/"$dataset"@rewrite1 | pv -s "$stream_size" | zfs recv -u storage/"$dataset"_new

printf 'Copied'
zfs list -r storage/"$dataset" storage/"$dataset"_new

printf 'Swap dataset names'
zfs unmount -f storage/"$dataset"
zfs rename storage/"$dataset" storage/"$dataset"_old
zfs rename storage/"$dataset"_new storage/"$dataset"
zfs set mountpoint=/storage/"$dataset" storage/"$dataset"
zfs set canmount=on storage/"$dataset"
printf 'Load dataset key and change key to root'
zfs load-key storage/"$dataset"
zfs change-key -i storage/m"$dataset"
zfs get encryptionroot storage/"$dataset"
printf 'Mount dataset'
zfs mount storage/"$dataset"