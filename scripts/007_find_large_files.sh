#!/bin/bash
set -euo pipefail

DIRECTORY="${1:-.}"
SIZE="${SIZE:-100M}"

echo "Files larger than $SIZE under $DIRECTORY:"
find "$DIRECTORY" -type f -size "+$SIZE" -printf '%s %p\n' 2>/dev/null |
    sort -nr |
    numfmt --field=1 --to=iec --suffix=B

