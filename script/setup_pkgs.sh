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
		htop \
		iotop \
		ipython3 \
		python-is-python3 \
		python3-pip \
		screen \
		slack-desktop \
		vim \
		vim-airline \
		vlc \
		-y
}

main "$@"
