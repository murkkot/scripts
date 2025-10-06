#!/bin/bash

# $1 - input dir
# $2 - number of files to sort

for file in "$1"/*.{jpeg,jpg,png,tiff}; do
    if [ -f "$file" ]; then
        echo "Processing $file"
    fi
done