#!/bin/bash

set -euo pipefail

BACKUP="${1:-}"
DESTINATION="${2:-.}"

if [ -z "$BACKUP" ]; then
    echo "Usage: $0 <backup.tar.gz> [destination]"
    exit 1
fi

if [ ! -f "$BACKUP" ]; then
    echo "Backup not found."
    exit 1
fi

mkdir -p "$DESTINATION"

tar -xzf "$BACKUP" -C "$DESTINATION"

echo "Backup restored successfully."
