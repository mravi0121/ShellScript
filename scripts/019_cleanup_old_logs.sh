#!/bin/bash

set -euo pipefail

LOG_DIR="${1:-/var/log}"
DAYS="${2:-30}"

find "$LOG_DIR" \
    -type f \
    -name "*.log" \
    -mtime +"$DAYS" \
    -print
