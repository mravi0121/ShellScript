#!/bin/bash

set -euo pipefail

DOMAIN="${1:-google.com}"

if getent hosts "$DOMAIN"; then
    echo "SUCCESS: DNS resolution works for $DOMAIN."
else
    echo "ERROR: DNS resolution failed for $DOMAIN."
    exit 1
fi
