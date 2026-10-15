#!/bin/bash

set -euo pipefail

who

echo
echo "User count:"
who | wc -l
