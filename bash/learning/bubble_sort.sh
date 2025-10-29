#!/bin/bash

args=("$@")
num_args=${#args[@]}

for arg in "${args[@]}"; do
    if [[ ! "$arg" =~ ^[0-9]+$ ]]; then
        echo "All input parameters must be numbers"
        exit 1
    fi
#    echo "$arg"
done

echo "inputcount: $num_args"
echo "content of inputValue: ${args[@]}"
echo -e "[Input] Enter your choice [Input]\n1.Ascending\n2.Descending"
read sort_order

if [[ "$sort_order" =~ ^[0-9]+$ ]]; then
    if [ "$sort_order" -ne 1 ] && [ "$sort_order" -ne 2 ]; then
        echo "You should input number between 1 and 2"
        exit 1
    fi
else
    echo "You should input number between 1 and 2"
    exit 1
fi

for (( i=0; i<num_args-1; i++ )); do
  for (( j=0; j<num_args-i-1; j++ )); do
    if (( $sort_order == 1 )); then
        if (( ${args[j]} > ${args[j+1]} )); then
            temp=${args[j]}
            args[j]=${args[j+1]}
            args[j+1]=$temp
        fi
    else
        if (( ${args[j]} < ${args[j+1]} )); then
            temp=${args[j]}
            args[j]=${args[j+1]}
            args[j+1]=$temp
        fi
    fi
  done
done

if (( $sort_order == 1 )); then
    echo "[OUTPUT] Ascending Order [OUTPUT]"
    echo "${args[@]}"
else
    echo "[OUTPUT] Descending Order [OUTPUT]"
    echo "${args[@]}"
fi