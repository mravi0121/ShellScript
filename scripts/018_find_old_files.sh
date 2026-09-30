#!/bin/bash

set -euo pipefail

DIRECTORY="${1:-.}"
DAYS="${2:-30}"

find "$DIRECTORY" \
    -type f \
    -mtime +"$DAYS" \
    -print
