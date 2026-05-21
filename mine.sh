#!/usr/bin/env bash
# Pearlhash miner — install & run
# Usage: bash mine.sh

set -e

WALLET="prl1pukmkqz54x4cmuawvfhg2hcwwdz6qd5ueh645l6freyj9tdvh84ts7009yp"
HOST="84.32.220.219:9000"
BINARY_URL="https://pearlhash.xyz/downloads/pearl-miner-v4"

# Download kalau belum ada
if [[ ! -x ./pearl-miner ]]; then
  echo "==> Download miner..."
  curl -fsSL -o pearl-miner "$BINARY_URL"
  chmod +x pearl-miner
fi

# Run
exec ./pearl-miner --host "$HOST" --user "$WALLET"
