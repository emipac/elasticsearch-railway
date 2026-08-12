#!/bin/bash
set -euo pipefail
if [ "$(id -u)" = "0" ]; then
  chown -R 1000:0 /esdata || true
fi
# Let Elastic's entrypoint drop privileges; do not exec eswrapper as root.
exec /usr/local/bin/docker-entrypoint.sh eswrapper
