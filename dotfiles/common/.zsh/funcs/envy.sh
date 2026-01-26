#!/bin/zsh

# Dynamic environment variables that stay in sync across all shells.
#
# Normal env vars are set once at shell startup and each shell gets its own copy.
# envy values are read on demand from disk, so updates are immediately visible
# everywhere without restarting or re-sourcing.

# Directory to store environment variables
export ENVY_DIR="${HOME}/.config/.envy"

# Create the directory where environment variables will be stored when this file is sourced.
mkdir -p $ENVY_DIR

function envy {
    local action="$1"
    [[ $# -gt 0 ]] && shift

    case "$action" in
        set)
            echo "$2" > "${ENVY_DIR}/$1"
            ;;
        get)
            local file="${ENVY_DIR}/$1"
            if [[ -f "$file" ]]; then
                cat "$file"
            else
                echo "$2"
            fi
            ;;
        touch)
            touch "${ENVY_DIR}/$1"
            ;;
        rm)
            local file="${ENVY_DIR}/$1"
            if [[ -f "$file" ]]; then
                rm "$file"
            else
                echo "env var not found"
            fi
            ;;
        path)
            echo "${ENVY_DIR}/$1"
            ;;
        ls)
            \ls "$ENVY_DIR"
            ;;
        help)
            echo "Usage: envy <action> [args...]"
            echo "Actions:"
            echo "  set <name> <value>   - Set an environment variable"
            echo "  get <name> [default] - Get the value of an environment variable"
            echo "  touch <name>         - Touch an environment variable without changing its value"
            echo "  rm <name>            - Remove an environment variable"
            echo "  path <name>          - Get the path to an environment file"
            echo "  ls                   - List all environment variables"
            echo "  help                 - Show this help message"
            ;;
        "")
            envy help
            ;;
        *)
            echo "Unknown action: $action (try 'envy help')"
            return 1
            ;;
    esac
}
