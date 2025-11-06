#!/usr/bin/env bash

arg="${1:-World}"

if [ $# -gt 1 ]; then
    echo "This program accepts only one argument" >&2
else
    echo "Hello, $arg"
fi