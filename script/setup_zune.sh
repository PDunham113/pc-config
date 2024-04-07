#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR

main() {
    sudo apt update

    setup_zune
}

setup_zune() {
    echo 'Installing mtp-tools...'
    sudo apt install mtp-tools

    echo 'Copying Zune keyfile...'
	cp "${SCRIPT_DIR}/../config/zune:.mtpz_data" "${HOME}/.mtpz_data"



}

main "$@"
