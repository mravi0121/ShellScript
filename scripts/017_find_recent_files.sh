#!/bin/bash

set -euo pipefail

DIRECTORY="${1:-.}"

find "$DIRECTORY" \
    -type f \
    -mtime -1 \
    -print
