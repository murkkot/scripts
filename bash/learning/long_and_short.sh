#!/bin/bash

names=($(cat /etc/passwd | cut -d':' -f1))
longest="${names[0]}"
shortest="${names[0]}"

for name in "${names[@]}"; do
    if [ "${#longest}" -lt "${#name}" ]; then
        longest="$name"
    fi
    if [ "${#shortest}" -gt "${#name}" ]; then
        shortest="$name"
    fi
done

echo "[OUTPUT] Largest and Shortest UserName [OUTPUT]"
echo "Longest Username is $longest"
echo "Shortest Username is $shortest"