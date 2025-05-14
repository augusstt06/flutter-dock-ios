#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_FILE=${1:-"$SCRIPT_DIR/docker/config.json"}
echo "⚙️ Using config file: $CONFIG_FILE"