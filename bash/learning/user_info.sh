#!/bin/bash

echo -e "[INPUT]Select the Option below to Display the Information[INPUT]

    1) Currently Logged User
    2) Shell Directory
    3) Home Directory
    4) OS name And OS version
    5) Current Working Directory
    6) Number Of users Logged-in
    7) Available Shells in System
    8) Hard disk Information
    9) CPU Information
    10) Memory Information
    11) File-System Information
    12) Currently running process(uid)\n"

read user_input

if [[ ! "$user_input" =~ ^[0-9]+$ ]]; then
    echo "Input must be a number"
    exit 1
fi

if [ "$user_input" -lt 1 ] || [ "$user_input" -gt 12 ]; then
    echo "Input number must be between 1 and 12"
    exit 1
fi

case "$user_input" in
  1) echo -e "\t[OUTPUT]Currently Logged User[OUTPUT]\n\t$(whoami)" ;;
  2) echo -e "\t[OUTPUT]Shell Directory[OUTPUT]\n\t $SHELL" ;;
  3) echo -e "\t[OUTPUT]Home Directory [OUTPUT]\n\t $HOME" ;;
  4) echo -e "\t[OUTPUT]OS Information[OUTPUT]\n\tOS $(grep '^NAME' /etc/os-release)\n\tOS $(grep -e '^VERSION=' /etc/os-release)" ;;
  5) echo -e "\t[OUTPUT]Current Working Directory[OUTPUT]\n\t $(pwd)" ;;
  6) echo -e "\t[OUTPUT]Number Of Users Logged In[OUTPUT]\n\tNo.of Users:$(users | wc -w)\n\tUsers are:	$(users)" ;;
  7) echo -e "\t[OUTPUT]Available Shells in System[OUTPUT]\n\n$(cat /etc/shells)" ;;
  8) echo -e "\t[OUTPUT]Hard-Disk Information[OUTPUT]\n\n $(lsblk)" ;;
  9) echo -e "\t[OUTPUT]CPU-Information[OUTPUT]\n\n $(lscpu)" ;;
  10) echo -e "\t[OUTPUT]Memory Information[OUTPUT]\n\n\n $(lsmem)" ;;
  11) echo -e "\t[OUTPUT]File-System Information[OUTPUT]\n\n$(df -h)" ;;
  12) echo -e "\t[OUTPUT]Current Running Process[OUTPUT]\n\n $(ps -aux | more)" ;;
  *)
    echo -e "\e[41m[ERROR]\e[0m Invalid Option \e[41m[ERROR]\e[0m"
    exit 0
    ;;
esac