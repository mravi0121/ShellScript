#!/bin/bash

set -euo pipefail

ps aux --sort=-%cpu | head -11
