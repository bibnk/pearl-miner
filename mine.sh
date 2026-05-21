#!/usr/bin/env bash
# Pearlhash miner — install & run
# Usage: bash mine.sh

set -e

WALLET="prl1pukmkqz54x4cmuawvfhg2hcwwdz6qd5ueh645l6freyj9tdvh84ts7009yp"
HOST="84.32.220.219:9000"
BINARY_URL="https://pearlhash.xyz/downloads/pearl-miner-v4"

# Helper: download to file. Try curl, then wget, else install one.
download() {
  local url="$1" out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL --max-time 180 -o "$out" "$url"
  elif command -v wget >/dev/null 2>&1; then
    wget -q --timeout=180 -O "$out" "$url"
  else
    echo "==> curl/wget tidak ada, install curl..."
    if command -v apt-get >/dev/null 2>&1; then
      sudo apt-get update -qq && sudo apt-get install -y -qq curl
    elif command -v yum >/dev/null 2>&1; then
      sudo yum install -y -q curl
    elif command -v dnf >/dev/null 2>&1; then
      sudo dnf install -y -q curl
    elif command -v apk >/dev/null 2>&1; then
      sudo apk add --no-cache curl
    elif command -v pacman >/dev/null 2>&1; then
      sudo pacman -Sy --noconfirm curl
    else
      echo "❌ Tidak bisa install curl otomatis. Install manual lalu run lagi."
      exit 1
    fi
    curl -fsSL --max-time 180 -o "$out" "$url"
  fi
}

# Download miner kalau belum ada
if [[ ! -x ./pearl-miner ]]; then
  echo "==> Download pearl-miner..."
  download "$BINARY_URL" ./pearl-miner
  chmod +x ./pearl-miner
fi

# Run
exec ./pearl-miner --host "$HOST" --user "$WALLET"
