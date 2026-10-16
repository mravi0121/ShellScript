# Server Connectivity Check

A Bash script to check TCP connectivity for multiple servers across common ports and generate a CSV report.

## Features
- Checks multiple servers using `servers.csv`.
- Tests ports **22, 80, 443, 8080, and 8443**.
- Uses Telnet with a 5-second timeout.
- Generates a `connectivity_report.csv` with `SUCCESS` or `FAILED` status.

## Input File
Create a `servers.csv` file with the following format:

```csv
ServerName,ServerIP
Server1,192.168.1.10
Server2,192.168.1.20
```

## Prerequisites
- Bash
- `telnet`
- `timeout`

## Usage

```bash
chmod +x test_connectivity.sh
./test_connectivity.sh
```

## Output
The script generates `connectivity_report.csv` containing each server's IP address and connectivity status for all five ports.

**Note:** `FAILED` indicates that the connection was not established within the timeout. Check the server, network, firewall, and whether the target port is listening.