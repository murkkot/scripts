#!/bin/bash

if [ ! -e $1 ]; then
    echo "Input file does not exist"
    exit 1
fi

echo -e "[INPUT] Please Select an option [INPUT]\n1.TO_UPPER_CASE\n2.to_lower_case"
read user_input

if [[ "$user_input" =~ ^[0-9]+$ ]]; then
    if [ "$user_input" -ne 1 ] && [ "$user_input" -ne 2 ]; then
        echo "You should enter 1 or 2"
        exit 1
    fi
else
    echo "You should enter only digits"
    exit 1
fi

echo "[OUTPUT] Content of Input File AFTER OPERATION [OUTPUT]"
while IFS= read -r line || [[ -n $line ]]; do
    if [ "$user_input" -eq 1 ]; then
        echo "$line" | tr "[:lower:]" "[:upper:]"
    else
        echo "$line" | tr "[:upper:]" "[:lower:]"
    fi
done < $1