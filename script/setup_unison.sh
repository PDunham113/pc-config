#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
readonly SCRIPT_DIR

readonly GITHUB_API_URL='https://api.github.com/repos'
readonly UNISON_REPO='bcpierce00/unison/releases/latests'
readonly UNISON_TMP='/tmp/unison'

main() {
    setup_unison
}

setup_unison() {
    echo 'Downloading unison...'
    curl -s "${GITHUB_API_URL}/${UNISON_REPO}" | grep 'browser_download_url":.*deb' \
    | cut -d : -f 2,3 | tr -d \" \
    | wget -qi - -O "${UNISON_TMP}/unison-static.tar.gz"

    echo 'Installing unison...'
    tar -xzf "${UNISON_TMP}/unison-static.tar.gz"
    mv "${UNISON_TMP}/bin/unison" '/usr/local/bin/unison'
    mv "${UNISON_TMP}/bin/unison-fsmonitor" '/usr/local/bin/unison-fsmonitor'
    mv "${UNISON_TMP}/unison-manual.txt" '/usr/local/man/unison-manual.txt'

    echo 'unison installed!'

    # Do config here
}

main "$@"
