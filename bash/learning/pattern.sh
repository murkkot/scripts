#!/bin/bash

echo "[INPUT]Enter the value of N[INPUT]"
read user_input

counter=1

if [[ "$user_input" =~ ^[0-9]+$ ]]; then
    for (( i=1; i<=$user_input; i++)); do
        for (( j=1; j<$i; j++ )); do
            echo -n "$counter"
            echo -n ' '
            (( counter++ ))
        done
        echo ''
    done
else
    echo "You should enter a number"
fi