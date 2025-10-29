#!/bin/bash

echo "[INPUT]Enter  the value of N[INPUT]"
read user_input

line_count=1
counter=1

if [[ "$user_input" =~ ^[0-9]+$ ]]; then
    for (( i=0; i<$user_input; i++)); do
        for (( j=0; j<$line_count; j++ )); do
            echo -n "$counter"
            echo -n ' '
            (( counter++ ))
        done
        echo ''
        (( line_count++ ))
    done
else
    echo "You should enter a number"
fi