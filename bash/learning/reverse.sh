#!/usr/bin/env bash

echo "**********Enter the value that is need to be reversed**********"
read word

for (( i=${#word}-1; i>=0; i-- )); do
    echo -n "${word:$i:1}"
done
echo