#!/bin/bash
set -euo pipefail

if [ "$(id -u)" = "0" ]; then
  chown -R 1000:0 /esdata || true
  exec gosu 1000:0 /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
fi

exec /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
