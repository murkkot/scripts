#!/usr/bin/env bash

args=("$@")
num_args=$#

for ((i=0; i<num_args; i++)); do
    num=$((i + 1))
    printf 'Var #%d:\t%s\n' "$num" "${args[i]}" 
done