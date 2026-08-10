#!/bin/bash

# Run the setup script for this machine.
#
# NOTE: Must be bash since it runs on a fresh install before zsh is available.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$(uname)" in
    Darwin)
        exec "${REPO_ROOT}/setup_macos.sh" "$@"
        ;;
    Linux)
        exec "${REPO_ROOT}/setup_arch.sh" "$@"
        ;;
    *)
        echo "Unsupported OS: $(uname)" >&2
        exit 1
        ;;
esac
