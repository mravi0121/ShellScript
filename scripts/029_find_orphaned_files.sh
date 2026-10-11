#!/bin/bash

set -euo pipefail

DIRECTORY="${1:-/}"

find "$DIRECTORY" -xdev -nouser -print 2>/dev/null || true

find "$DIRECTORY" -xdev -nogroup -print 2>/dev/null || true
