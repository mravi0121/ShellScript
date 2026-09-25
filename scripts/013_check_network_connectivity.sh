#!/bin/bash

set -euo pipefail

HOST="${1:-google.com}"

if ping -c 3 "$HOST" >/dev/null 2>&1; then
    echo "SUCCESS: $HOST is reachable."
else
    echo "ERROR: $HOST is unreachable."
    exit 1
fi
