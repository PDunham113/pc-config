#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR


main() {
	add_vagrant_repo
	add_virtualbox_repo
	sudo apt update

	setup_pkgs
}

setup_pkgs() {
	sudo apt install \
		discord \
		htop \
		iotop \
		ipython3 \
		lm-sensors \
		python-is-python3 \
		python3-pip \
		screen \
		solaar \
		slack-desktop \
		vagrant \
		virtualbox-7.0 \
		vim \
		vim-airline \
		vlc \
		-y

	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo flatpak install flathub fr.handbrake.ghb
}

add_vagrant_repo() {
	readonly VAGRANT_RELEASE_URL='https://apt.releases.hashicorp.com'
	readonly VAGRANT_KEYLOC='/usr/share/keyrings/hashicorp-archive-keyring.gpg'

	wget -O- "${VAGRANT_RELEASE_URL}/gpg" | sudo gpg --dearmor -o "${VAGRANT_KEYLOC}"
	signed_by="deb [signed-by=${VAGRANT_KEYLOC}] ${VAGRANT_RELEASE_URL} $(lsb_release -cs) main"
	echo "${signed_by}" | sudo tee /etc/apt/sources.list.d/hashicorp.list
}

add_virtualbox_repo() {
	readonly VIRTUALBOX_KEYLOC='/usr/share/keyrings/oracle-virtualbox-2016.gpg'

	wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output "${VIRTUALBOX_KEYLOC}" --dearmor
	signed_by="deb [arch=amd64 signed-by=${VIRTUALBOX_KEYLOC}] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
	echo "${signed_by}" | sudo tee /etc/apt/sources.list.d/oracle.list
}

main "$@"
