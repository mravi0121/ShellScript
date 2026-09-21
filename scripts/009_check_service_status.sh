#!/bin/bash

set -euo pipefail

SERVICE="${1:-ssh}"

if systemctl is-active --quiet "$SERVICE"; then
    echo "SUCCESS: $SERVICE is running."
else
    echo "ERROR: $SERVICE is not running."
    systemctl status "$SERVICE" --no-pager || true
    exit 1
fi
