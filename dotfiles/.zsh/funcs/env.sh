#!/bin/bash

# Use directory of files as a simple key value store.
#
# This should be used when environment variables need
# to remain consistent across all active shells.

# Directory to store environment variables
export ENV_DIR="${XDG_CONFIG_HOME}/.env"

# Set an environment variable.
# Arguments:
#   $1 - The name of the environment variable.
#   $2 - The value to set for the environment variable.
function envset {
    echo "$2" > "${ENV_DIR}/$1"
}

# Get the value of an environment variable
# Arguments:
#   $1 - The name of the environment variable to retrieve
#   $2 - (Optional) A default value to return if the variable does not exist
function envget {
  local buf_indicators = string.format("%s current buffer, %s alternate buffer", fzf_utils.ansi_codes.red("%"), fzf_utils.ansi_codes.yellow("#"))
    local file="${ENV_DIR}/$1"
    if [[ -f "$file" ]]; then
        cat "$file"
    else
        echo "$2"
    fi
}

# Touch an environment variable without changing its value.
# Useful if environment variable files are being watched for changes.
# Arguments:
#   $1 - The name of the environment variable to touch.
function envtouch {
    touch "${ENV_DIR}/$1"
}

# Remove an environment variable.
# Arguments:
#   $1 - The name of the environment variable to remove.
function envrm {
    local file="${ENV_DIR}/$1"
    if [[ -f "$file" ]]; then
        rm "$file"
    else
        echo "env var not found"
    fi
}

# List all environment variables.
# Arguments:
#   None
function envls {
    \ls "$ENV_DIR"
}
