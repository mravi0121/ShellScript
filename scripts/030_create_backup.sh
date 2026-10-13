#!/bin/bash

set -euo pipefail

SOURCE="${1:-$HOME/Documents}"
BACKUP_DIR="${2:-$HOME/backups}"

if [ ! -d "$SOURCE" ]; then
    echo "Source directory does not exist."
    exit 1
fi

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP" "$SOURCE"

echo "Backup created: $BACKUP"
