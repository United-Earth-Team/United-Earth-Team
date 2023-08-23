#!/bin/bash

RELATIVE_SHELL_DIR=$(dirname "$BASH_SOURCE")

has_error=0  # Flag variable, 0 means no errors found, 1 means at least one error was found

# Find all .sh files in the project directory and check their syntax
find "$RELATIVE_SHELL_DIR" -type f -name "*.sh" | while read -r script_file; do
    echo "checking syntax for: $script_file"
    if ! bash -n "$RELATIVE_SHELL_DIR/$script_file"; then
        has_error=1  # Set flag to indicate error
    fi
done

# Exit with appropriate status
if [ $has_error -eq 1 ]; then
    exit 1
else
    exit 0
fi