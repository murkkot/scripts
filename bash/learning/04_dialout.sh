#!/usr/bin/env bash

command=$1

if [ $# -ne 1 ]; then
    printf 'Usage: %s [COMMAND]\n' "${0##*/}" >&2
    exit 2
fi

eval "$command" 1> >(tee output.txt) 2> >(tee error.txt >&2)