#!/usr/bin/env bash

shopt -s nullglob

logpath="$1"

if [ $# -ne 1 ]; then
    printf 'Usage: %s [PATH]\n' "${0##*/}"
    exit 2
fi

files=("$logpath"/*.log)

if [ "${#files[@]}" -eq 0 ]; then
    printf 'No log files in %s\n' "$logpath"
else
    for file in "${files[@]}"; do
        printf 'Filename: %-15s\tNumber of lines: %d\n' "${file##*/}" "$(cat $file | wc -l)"
    done
fi