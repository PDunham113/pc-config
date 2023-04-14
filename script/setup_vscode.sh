#!/usr/bin/env bash
set -e

readonly VSCODE_PKG='https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
readonly VSCODE_TMP='/tmp/vscode'

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
    echo 'Downloading VSCode...'
    mkdir -p "${VSCODE_TMP}"
    wget "${VSCODE_PKG}" -O "${VSCODE_TMP}/vscode.deb"
    sudo apt install "${VSCODE_TMP}/vscode.deb"

    echo 'Installing extensions...'
	code --install-extension johnpapa.vscode-peacock
    code --install-extension muuvmuuv.vscode-sundial

    echo 'Installing config...'
    mkdir -p "${HOME}/.config/Code/User"
    cp "${SCRIPT_DIR}/../config/vscode:settings.json" "${HOME}/.config/Code/User/settings.json"

    echo 'Installation complete!'
}

main "$@"
