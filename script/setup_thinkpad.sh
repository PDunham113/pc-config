#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR

main () {
    setup_thinkpad_fan
}

setup_thinkpad_fan() {
    sudo cp "${SCRIPT_DIR}/../config/thinkpad:thinkpad_acpi.conf" '/etc/modprobe.d/thinkpad_acpi.conf'
}

main "$@"
