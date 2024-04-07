#!/usr/bin/env bash
set -e

readonly ALACRITTY_REPO='https://github.com/alacritty/alacritty.git'
readonly ALACRITTY_TMP='/tmp/alacritty'

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
	sudo apt update

	setup_alacritty
}

setup_alacritty() {
	echo 'Checking out latest alacritty repo...'
	mkdir -p "${ALACRITTY_TMP}"
	git clone "${ALACRITTY_REPO}" "${ALACRITTY_TMP}"
	cd "${ALACRITTY_TMP}"

	echo 'Downloading deps...'
	setup_rust
	sudo apt install \
		cmake \
		pkg-config \
		libfreetype6-dev \
		libfontconfig1-dev \
		libxcb-xfixes0-dev \
		libxkbcommon-dev \
		python3 \
		-y

	echo 'Compiling...'
	cargo build --release

	echo 'Installing...'
	# Install terminfo
	sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
	# Install bin & desktop entry
	sudo cp 'target/release/alacritty' '/usr/local/bin'
	sudo cp 'extra/logo/alacritty-term.svg' '/usr/share/pixmaps/Alacritty.svg'
	sudo desktop-file-install 'extra/linux/Alacritty.desktop'
	sudo update-desktop-database
	# Installing manpages
	local -r MAN_LOC='/usr/local/share/man/man1'
	sudo mkdir -p "${MAN_LOC}"
	gzip -c 'extra/alacritty.man' | sudo tee "${MAN_LOC}/alacritty.1.gz" > '/dev/null'
	gzip -c 'extra/alacritty-msg.man' | sudo tee "${MAN_LOC}/alacritty-msg.1.gz" > '/dev/null'
	# Installing zsh shell completions
	#mkdir -p "${ZDOTDIR:-~}/.zsh_functions"
	#echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> "${ZDOTDIR:-~}/.zshrc"
	#cp 'extra/completions/_alacritty' "${ZDOTDIR:-~}/.zsh_functions/_alacritty"
	# Setting as default terminal
	sudo update-alternatives --install '/usr/bin/x-terminal-emulator' x-terminal-emulator "$(which alacritty)" 50
	sudo update-alternatives --config x-terminal-emulator

	# Move our config file
	mkdir -p "${HOME}/.config/alacritty"
	cp "${SCRIPT_DIR}/../config/alacritty:alacritty.yml" "${HOME}/.config/alacritty/alacritty.yml"

	echo 'Installation complete!'
}

setup_rust() {
	echo 'Downloading rustup...'
	curl --proto '=https' --tlsv1.2 -sSf 'https://sh.rustup.rs' | sh
	source "$HOME/.cargo/env"

	echo "Ensure we're using the stable compiler"
	rustup override set stable
	rustup update stable
}

main "$@"
