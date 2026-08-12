#!/bin/bash
set -euo pipefail

if [ "$(id -u)" = "0" ]; then
  chown -R 1000:0 /esdata || true
  # Drop privileges before Elastic boots (ES 9 forbids root).
  if command -v setpriv >/dev/null 2>&1; then
    exec setpriv --reuid=1000 --regid=0 --clear-groups --inh-caps=-all \
      /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
  fi
  if command -v runuser >/dev/null 2>&1; then
    exec runuser -u elasticsearch -- /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
  fi
  if command -v su-exec >/dev/null 2>&1; then
    exec su-exec 1000:0 /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
  fi
  if command -v gosu >/dev/null 2>&1; then
    exec gosu 1000:0 /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
  fi
  echo "No privilege-dropping tool found (setpriv/runuser/su-exec/gosu)" >&2
  exit 1
fi

exec /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
