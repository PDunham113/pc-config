#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
	sudo apt update

	setup_pkgs

}

setup_pkgs() {
	sudo apt install \
		discord \
		git \
		htop \
		iotop \
		screen \
		slack-desktop \
		steam \
		vim \
		vlc \
		-y
}

main "$@"
