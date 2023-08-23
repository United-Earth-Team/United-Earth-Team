#!/bin/bash

RELATIVE_SHELL_DIR=$(dirname "$BASH_SOURCE")

# Find all .sh files in the project directory and check their syntax
find "$RELATIVE_SHELL_DIR" -type f -name "*.sh" | while read -r script_file; do
    echo "checking syntax for: $script_file"
    if bash -n "$script_file"; then
        echo "$script_file: syntax OK"
    else
        echo "$script_file: syntax Error!"
    fi
    echo "----------------------------------"
done