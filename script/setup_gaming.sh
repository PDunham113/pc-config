#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR

readonly GITHUB_API_URL='https://api.github.com/repos'
readonly GAMING_TMP='/tmp/gaming'


main() {
    sudo apt update

    sudo apt install \
        steam \
        -y

    setup_heroic_games_launcher
    setup_r2modman
}

setup_heroic_games_launcher() {
    readonly HEROIC_REPO='Heroic-Games-Launcher/HeroicGamesLauncher/releases/latest'


    echo 'Downloading Heroic Games Launcher...'
    curl -s "${GITHUB_API_URL}/${HEROIC_REPO}" | grep 'browser_download_url":.*deb"' \
        | cut -d : -f 2,3 | tr -d \" \
        | wget -qi - -O "${GAMING_TMP}/heroic.deb"

    echo 'Installing...'
    sudo apt install "${GAMING_TMP}/heroic.deb"

    echo 'Heroic Games Launcher installed!'
}

setup_r2modman() {
    readonly R2MODMAN_REPO='ebkr/r2modmanPlus/releases/latest'

    echo 'Downloading r2modman...'
    curl -s "${GITHUB_API_URL}/${R2MODMAN_REPO}" | grep 'browser_download_url":.*deb"' \
        | cut -d : -f 2,3 | tr -d \" \
        | wget -qi - -O "${GAMING_TMP}/r2modman.deb"

    echo 'Installing...'
    sudo apt install "${GAMING_TMP}/r2modman.deb"

    echo 'r2modman installed!'
}

main "$@"
