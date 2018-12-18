#!/usr/bin/env bash
# maybe will be used in a cron to force portus restart
# not yet used, we will see if clair bypass is not
# engouth
cd "$(dirname $(readlink -f "${0}"))"
set -e
if [[ -n $SHELLDEBUG ]];then
    set -x
fi
COMPOSE_FILES="-f docker-compose.cops.yml"
COMPOSE="{{cops_portus_composename}}"
SERVICES="portus background web nginx registry clair"
DC="docker-compose"
vv() { echo "$@";"$@"; }
while read f;do
    kill -9 $f || /bin/true
done < <(ps afux|egrep "clair|git-remote-http"|awk '{print $2}')
for i in $SERVICES;do
    vv $DC $COMPOSE_FILES -p $COMPOSE up -d --force-recreate --no-deps $i
done
# vim:set et sts=4 ts=4 tw=80:
