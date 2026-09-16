#!/bin/bash

set -euo pipefail

echo "System Load:"
uptime

echo
cat /proc/loadavg
