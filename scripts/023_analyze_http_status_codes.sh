#!/bin/bash

set -euo pipefail

LOG_FILE="${1:-access.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

awk '{
    for (i=1; i<=NF; i++)
        if ($i ~ /^[1-5][0-9][0-9]$/)
            print $i
}' "$LOG_FILE" |
sort |
uniq -c |
sort -nr
