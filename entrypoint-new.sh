#!/bin/bash
set -euo pipefail
# Railway mounts /esdata as root-owned; fix ownership then hand off to ES entrypoint.
chown -R 1000:0 /esdata || true
exec /bin/tini -- /usr/local/bin/docker-entrypoint.sh eswrapper
