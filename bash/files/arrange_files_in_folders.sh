#!/bin/bash

# $1 - input dir
# $2 - number of files per folder

input_dir="$1"
files_per_folder="$2"

if [ $# -ne 2 ]; then
  echo "Usage: $0 INPUT_DIR NUMBER_OF_FILES_PER_FOLDER"
  exit 1
fi

if [ ! -d "$input_dir" ]; then
    echo "Input dir $input_dir doesn't exists"
    exit 1
fi

if [[ ! "$files_per_folder" =~ ^[0-9]+$ ]]; then
    echo "Files per folder number must be positive integer"
    exit 1
fi

cd $input_dir

folder_num=1
file_num=0

folder_name=$(printf "%02d" "$folder_num")
mkdir -p "$input_dir/$folder_name"

for file in "$1"/*.{jpeg,jpg,png,tiff}; do
    if [ -f "$file" ]; then
        ((file_num++))
        mv "$file" "$folder_name" 
        if (( file_num % files_per_folder == 0 )); then
            ((folder_num++))
            folder_name=$(printf "%02d" "$folder_num")
            mkdir -p "$input_dir/$folder_name"
        fi     
    fi
done
