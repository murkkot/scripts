#!/usr/bin/env bash

shopt -s nullglob
dry_run=0

usage() {
    printf 'Usage: %s [OPTIONS] [PATH]\n' "${0##*/}"
    printf 'Options:\n'
    printf '%s\tdry run\n' '-n'
    printf '%s\thelp\n' '-h'
}

OPTERR=0
while getopts ":nh" opt; do
    case $opt in
        n) 
            dry_run=1
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            printf 'Invalid option -%s\n' "$OPTARG" >&2
            usage
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))
path="$1"

if [ $# -ne 1 ]; then
    usage
    exit 2
fi


#find "$path" -type f -name "*.tmp" -mtime +30 -print0 | while IFS= read -r -d '' file; do
find "$path" -type f -name "*.tmp" -print0 | while IFS= read -r -d '' file; do
    if [ "$dry_run" -eq 1 ]; then
        printf '[DRY RUN] Would delete %s\n' "$file"
    else
        while true; do
            read -rp "Delete '$file'? [y/Y]" ans </dev/tty
            case "$ans" in
                [yY]*) rm -v -- "$file"; break;;
                [nN]*) printf 'Skipping %s\n' "$file"; break;;
                *) printf 'Please enter [y/Y] or [n/N]\n';;
            esac
        done
    fi
done