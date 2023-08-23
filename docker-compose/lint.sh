#!/bin/bash

# Function to display the script's usage
display_help() {
    echo "Usage: $0 [DOCKER_COMPOSE_FILE]"
    echo
    echo "Positional arguments:"
    echo "  DOCKER_COMPOSE_FILE  Name of the Compose YAML file. Default is 'compose.yaml'."
    echo
    echo "Optional arguments:"
    echo "  -h, --help           Display this help message."
    exit 1
}

# Check for the help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    display_help
fi

COMPOSE_YAML=${1: -"compose.yaml"}
RELATIVE_SHELL_DIR=$(dirname "$BASH_SOURCE")

sh_has_error=0  # flag variable, 0 means no errors found, 1 means at least one error was found

# find all .sh files in the project directory and check their syntax
find "$RELATIVE_SHELL_DIR" -type f -name "*.sh" | while read -r script_file; do
    echo "checking syntax for: $script_file"
    if ! bash -n "$script_file"; then
        sh_has_error=1  # set flag to indicate error
    fi
done

echo "checking ${COMPOSE_YAML}..."
docker compose -f $COMPOSE_YAML config > /dev/null
docker_compose_return_code=$?

# exit with appropriate status
if [ $sh_has_error -eq 0 ] && [ $docker_compose_return_code -eq 0] ; then
    echo "check passed."
    exit 0
else
    echo "check failed."
    exit 1
fi
