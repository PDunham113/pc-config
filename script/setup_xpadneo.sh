#!/usr/bin/env bash
set -e

readonly XPADNEO_REPO='https://github.com/atar-axis/xpadneo.git'
readonly XPADNEO_TMP='/tmp/xpadneo'

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
	sudo apt update

	setup_xpadneo

}

setup_xpadneo() {
	echo 'Checking out latest xpadneo repo...'
	mkdir -p "${XPADNEO_TMP}"
	git clone "${XPADNEO_REPO}" "${XPADNEO_TMP}"
	cd "${XPADNEO_TMP}"

	echo 'Downloading deps...'
	sudo apt install \
		dkms \
		"linux-headers-$(uname -r)" \
		-y

	echo 'Installing...'
	sudo ./install.sh

	echo 'Installation complete!'
}

main "$@"
