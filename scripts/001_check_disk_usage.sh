#!/bin/bash

# ==========================================================
# Script Name : check_disk_usage.sh
# Description : Check disk usage and warn above threshold
# ==========================================================

set -euo pipefail

THRESHOLD=80

echo "Checking disk usage..."
echo

df -hP | awk -v threshold="$THRESHOLD" '
NR > 1 {
    usage=$5
    gsub("%","",usage)

    if (usage >= threshold) {
        print "WARNING: " $6 " is " usage "% full"
    } else {
        print "OK: " $6 " is " usage "% full"
    }
}'
