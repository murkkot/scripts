#!/bin/bash


file_array=($(df --output=source))
usage_array=($(df --output=pcent | cut -d '%' -f 1))
count=0

echo "[INPUT] Enter the usage [INPUT]"
read input_usage

if [[ ! "$input_usage" =~ ^[0-9]+$ ]]; then
    echo "You should enter a number"
    exit 1
fi

for ((i = 1; i < ${#usage_array[@]}; i++)); do
  if [ "${usage_array[$i]}" -ge $input_usage ]; then
    count=1
    echo "file system \"${file_array[i]}\"  has \"$((100 - ${usage_array[$i]}))%\" of freespace and used space of ${usage_array[$i]}%"
  fi
done

if [ $count -eq 0 ]; then
  echo "No file System has usage of $((100 - $input_usage))% of freespace"
fi