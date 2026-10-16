#!/bin/bash

set -euo pipefail

SERVICE="${1:-tomcat}"
LOG_FILE="${2:-/tmp/tomcat-auto-restart.log}"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Checking $SERVICE service."

if systemctl is-active --quiet "$SERVICE"; then
    log "$SERVICE is running."
    exit 0
fi

log "$SERVICE is down."
log "Attempting to restart $SERVICE."

systemctl restart "$SERVICE"

sleep 10

if systemctl is-active --quiet "$SERVICE"; then
    log "$SERVICE restarted successfully."
    exit 0
fi

log "ERROR: Failed to restart $SERVICE."

systemctl status "$SERVICE" --no-pager >> "$LOG_FILE" 2>&1 || true

exit 1
