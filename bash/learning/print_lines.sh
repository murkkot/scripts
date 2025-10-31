#!/usr/bin/env bash

start_line=$1
num_lines=$2
filename=$3

if [[ ! "$start_line" =~ ^[0-9]+$ ]] || [[ ! "$num_lines" =~ ^[0-9]+$ ]]; then
    echo "You should input START_LINE for the first argument and NUMBER_OF_LINES for the second"
    exit 1
fi

if [ ! -f "$filename" ]; then
    echo "Input file doesn't exist"
    exit 1
fi

tail -n +"$start_line" "$filename" | head -n "$num_lines"