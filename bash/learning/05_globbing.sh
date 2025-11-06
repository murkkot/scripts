#!/usr/bin/env bash

#shopt -s nullglob
#shopt -s failglob
#shopt -s dotglob

echo "======= Default ======="
echo z*.txt

echo "======= Nullglob ======="
shopt -s nullglob
echo z*.txt
shopt -u nullglob

echo "======= Failglob ======="
shopt -s failglob
echo z*.txt
shopt -u failglob

echo "======= Hidden files ======= {echo .*}"
echo .*

echo "======= Hidden files with dotglob ======= {echo *}"
shopt -s dotglob
echo *
shopt -u dotglob