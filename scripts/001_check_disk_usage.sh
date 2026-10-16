#!/bin/bash

set -euo pipefail

THRESHOLD="${1:-80}"

df -hP | awk -v threshold="$THRESHOLD" '
NR > 1 {
    usage=$5
    gsub("%","",usage)

    if (usage >= threshold)
        print "WARNING: " $6 " is " usage "% full"
    else
        print "OK: " $6 " is " usage "% full"
}'
