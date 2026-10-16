#!/bin/bash

set -euo pipefail

FILE="${1:-/etc/passwd}"

if [ ! -e "$FILE" ]; then
    echo "File does not exist: $FILE"
    exit 1
fi

ls -l "$FILE"
stat "$FILE"
