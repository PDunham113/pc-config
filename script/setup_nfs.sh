#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR

main() {
    sudo apt update

    setup_nfs
}

setup_nfs() {
    echo "Installing NFS prereqs..."
    sudo apt install \
    autofs \
    nfs-common \
    -y

    echo "Installing config.."
    sudo cp "${SCRIPT_DIR}/../config/nfs:20-pc-config.autofs" '/etc/auto.master.d/20-pc-config.autofs'
    sudo cp "${SCRIPT_DIR}/../config/nfs:auto.mimir" '/etc/auto.mimir'

    sudo systemctl reload autofs.service
    echo "Installation complete!"
}

main "$@"
