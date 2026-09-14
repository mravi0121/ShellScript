#!/bin/bash

set -euo pipefail

free -h

MEMORY_USAGE=$(free | awk '/Mem:/ {
    printf "%.0f", ($3/$2)*100
}')

echo
echo "Memory Usage: ${MEMORY_USAGE}%"

if [ "$MEMORY_USAGE" -ge 80 ]; then
    echo "WARNING: Memory usage is above 80%"
else
    echo "OK: Memory usage is normal"
fi
