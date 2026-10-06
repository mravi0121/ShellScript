#!/bin/bash

set -euo pipefail

if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log || true
elif [ -f /var/log/secure ]; then
    grep "Failed password" /var/log/secure || true
else
    echo "Authentication log not found."
fi
