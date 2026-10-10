#!/bin/bash

set -euo pipefail

DIRECTORY="${1:-.}"

find "$DIRECTORY" \
    -type f \
    -perm -0002 \
    -print
