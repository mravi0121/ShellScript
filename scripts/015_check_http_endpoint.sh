#!/bin/bash

set -euo pipefail

URL="${1:-https://example.com}"

HTTP_STATUS=$(curl -L -s \
    -o /dev/null \
    -w "%{http_code}" \
    "$URL")

echo "URL: $URL"
echo "HTTP Status: $HTTP_STATUS"

if [[ "$HTTP_STATUS" =~ ^[23][0-9][0-9]$ ]]; then
    echo "SUCCESS: Endpoint is healthy."
else
    echo "ERROR: Endpoint returned HTTP $HTTP_STATUS."
    exit 1
fi
