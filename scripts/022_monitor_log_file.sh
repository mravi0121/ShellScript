#!/bin/bash

set -euo pipefail

LOG_FILE="${1:-/var/log/syslog}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

tail -F "$LOG_FILE" | grep --line-buffered -Ei "error|failed|critical"
