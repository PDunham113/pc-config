#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
	sudo apt update
	
	setup_zsh
	
}

setup_zsh() {
	echo 'Installing zsh'
	sudo apt install -y zsh

	echo 'Setting as default shell'
	chsh -s $(which zsh)

	echo 'Installing oh-my-zsh'
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

main "$@"
