#!/usr/bin/env bash
# See Dockerfile
# ENTRYPOINT thisFile
# RUN server run
set -e
[[ ${DEBUG_STARTUP,,} = true ]] && set -xv

if [[ $1 != server ]]; then
    exec "$@"
fi

shift
./ucd_data_copy.sh
[[ -f /setup_certs.sh ]] && /setup_certs.sh
exec ./bin/server "$@"

