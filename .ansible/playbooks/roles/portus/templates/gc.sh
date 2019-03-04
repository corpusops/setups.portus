#!/bin/bash
cd "$(dirname $(readlink -f "${0}"))"
set -e
if [[ -n $SHELLDEBUG ]];then
    set -x
fi
COMPOSE_FILES="-f docker-compose.cops.yml"
COMPOSE="portus"
SERVICES="background web nginx portus"
DC="docker-compose"
vv() { echo "$@";"$@"; }
vv $DC $COMPOSE_FILES -p $COMPOSE exec -T registry /entrypoint.sh garbage-collect /etc/docker/registry/config.yml --delete-untagged=true --dry-run=false
# vim:set et sts=4 ts=4 tw=80:
