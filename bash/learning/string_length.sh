#!/bin/bash

args=("$@")

if [ $# -gt 0 ]; then
    echo "[OUTPUT] String length of given values [OUTPUT]"
    for arg in "${args[@]}"; do
        num_letters=${#arg}
        echo "Length of the String("${arg}"): $num_letters" 
    done
else
    echo "You should pass one or more arguments"
    exit 1
fi