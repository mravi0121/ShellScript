#!/bin/bash

set -euo pipefail

ps aux --sort=-%mem | head -11
