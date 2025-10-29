#!/bin/bash

args=("$@")
num_args=$#

for arg in "${args[@]}"; do
    if [[ ! "$arg" =~ ^[0-9]+$ ]]; then
        echo "You need to enter digits only"
        exit 1
    fi
done

if [ "$num_args" -lt 1 ]; then
    echo "You need to enter 1 or more numbers"
    exit 1
fi

result="${args[0]}"
for arg in "${args[@]}"; do
    if [ "$arg" -gt "$result" ]; then
        result="${arg[i]}"
    fi
done

echo "Largest number in the integer values is: $result"