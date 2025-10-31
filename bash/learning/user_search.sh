#!/usr/bin/env bash

echo "[INPUT] Enter the username [INPUT]"
read name

 result=$(cat /etc/passwd | grep "$name" | cut -f1 -d':')

 if [ -z "$result" ]; then
    echo "[OUTPUT] USER $name IS NOT PRESENT [OUTPUT]"
 else
    echo "[OUTPUT] USER $name IS PRESENT [OUTPUT]"
fi