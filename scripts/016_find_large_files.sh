#!/bin/bash

set -euo pipefail

DIRECTORY="${1:-.}"
SIZE="${2:-100M}"

find "$DIRECTORY" \
    -type f \
    -size +"$SIZE" \
    -exec ls -lh {} \;
