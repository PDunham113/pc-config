#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
    echo 'Downloading git...'
    sudo apt install git

    echo 'Installing config...'
    cp "${SCRIPT_DIR}/../config/git:.gitconfig" "${HOME}/.gitconfig"

    echo 'Installation complete!'
}

main "$@"
