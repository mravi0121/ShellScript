#!/bin/bash

set -euo pipefail

PID="${1:-}"

if [ -z "$PID" ]; then
    echo "Usage: $0 <PID>"
    exit 1
fi

if ! kill -0 "$PID" 2>/dev/null; then
    echo "Process $PID does not exist."
    exit 1
fi

kill "$PID"

echo "Termination signal sent to process $PID."
