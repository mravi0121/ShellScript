#!/bin/bash

set -euo pipefail

LOG_DIR="${1:-/tmp/logs}"
OUTPUT_DIR="${2:-$HOME/log-archives}"

if [ ! -d "$LOG_DIR" ]; then
    echo "Directory not found: $LOG_DIR"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$OUTPUT_DIR/logs_$TIMESTAMP.tar.gz"

tar -czf "$ARCHIVE" "$LOG_DIR"

echo "Archive created:"
echo "$ARCHIVE"
