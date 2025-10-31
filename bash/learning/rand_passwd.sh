#!/usr/bin/env bash

echo "[INPUT] Enter the Number of Password to Generate [INPUT]"
read num

if [[ ! "$num" =~ ^[0-9]+$ ]]; then
    echo "You need to enter a positive number" >&2
    exit 1
fi

echo "[INPUT] Enter the Number of Passwords to Generate [INPUT]"
read len

if [[ ! "$len" =~ ^[0-9]+$ ]]; then
    echo "You need to enter a positive number" >&2
    exit 1
fi

cat /dev/urandom | tr -cd 'a-zA-Z0-9~!@#$%^&*()_+}{":?><' | fold -w "$len" | head -n "$num"