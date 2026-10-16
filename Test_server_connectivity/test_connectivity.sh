#!/bin/bash

INPUT_FILE="servers.csv"
OUTPUT_FILE="connectivity_report.csv"
PORTS=(22 80 443 8080 8443)
TIMEOUT=5

# Check input file
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "ERROR: $INPUT_FILE not found!"
    exit 1
fi

# Check required commands
for CMD in telnet timeout; do
    if ! command -v "$CMD" >/dev/null 2>&1; then
        echo "ERROR: Required command '$CMD' is not installed."
        exit 1
    fi
done

# Create CSV header
echo "ServerName,ServerIP,Port_22_Status,Port_80_Status,Port_443_Status,Port_8080_Status,Port_8443_Status" > "$OUTPUT_FILE"

COUNT=0

# Read CSV using file descriptor 3
while IFS=',' read -r SERVER_NAME SERVER_IP <&3 || [[ -n "$SERVER_NAME$SERVER_IP" ]]; do

    # Remove spaces and carriage returns
    SERVER_NAME=$(printf '%s' "$SERVER_NAME" | tr -d '\r' | xargs)
    SERVER_IP=$(printf '%s' "$SERVER_IP" | tr -d '\r' | xargs)

    # Skip header and empty lines
    [[ "$SERVER_NAME" == "ServerName" ]] && continue
    [[ -z "$SERVER_NAME" || -z "$SERVER_IP" ]] && continue

    COUNT=$((COUNT + 1))

    echo "[$COUNT] Checking $SERVER_NAME ($SERVER_IP)"

    # Initialize result row
    RESULT="$SERVER_NAME,$SERVER_IP"

    # Check each port using Telnet
    for PORT in "${PORTS[@]}"; do

        if timeout "$TIMEOUT" telnet "$SERVER_IP" "$PORT" \
            </dev/null 2>&1 | grep -qi "Connected to"; then
            STATUS="SUCCESS"
        else
            STATUS="FAILED"
        fi

        RESULT="$RESULT,$STATUS"

        echo "    Port $PORT: $STATUS"
    done

    # Write one row per server
    echo "$RESULT" >> "$OUTPUT_FILE"

    echo "--------------------------------------------"

done 3< "$INPUT_FILE"

echo ""
echo "Connectivity check completed."
echo "Total servers checked: $COUNT"
echo "Total port checks: $((COUNT * ${#PORTS[@]}))"
echo "Report saved to $OUTPUT_FILE"