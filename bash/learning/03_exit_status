#!/usr/bin/env bash

command=$1

if [ $# -ne 1 ]; then
    printf 'Usage: %s [COMMAND]\n' "${0##*/}" >&2
    exit 2
fi

eval "$command"
result="$?"

printf 'result %d: %s\n' "$result" "$([ "$result" -eq 0 ] && printf OK || printf FAIL)"