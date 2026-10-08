#!/bin/bash

set -euo pipefail

DIRECTORY="${1:-.}"

du -h --max-depth=1 "$DIRECTORY" 2>/dev/null |
sort -hr |
head -20
