#!/bin/bash

set -euo pipefail

USER_NAME="${1:-$USER}"
BACKUP_DIR="${2:-$HOME/backups}"

USER_HOME=$(getent passwd "$USER_NAME" | cut -d: -f6)

if [ -z "$USER_HOME" ] || [ ! -d "$USER_HOME" ]; then
    echo "User home directory not found."
    exit 1
fi

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP="$BACKUP_DIR/${USER_NAME}_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP" "$USER_HOME"

echo "Backup created: $BACKUP"
