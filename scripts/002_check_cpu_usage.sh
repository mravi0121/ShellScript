#!/bin/bash

set -euo pipefail

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {
    print 100 - $8
}')

echo "CPU Usage: ${CPU_USAGE}%"
