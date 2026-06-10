#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="$ROOT_DIR/.tools"
TWEEGO_BIN="$TOOLS_DIR/tweego"
TWEEGO_VERSION="2.1.1"
TWEEGO_ARCH="macos-x64"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Error: this helper currently targets macOS only."
  echo "Use official releases: https://github.com/tmedwards/tweego/releases"
  exit 1
fi

DOWNLOAD_URL="https://github.com/tmedwards/tweego/releases/download/v${TWEEGO_VERSION}/tweego-${TWEEGO_VERSION}-${TWEEGO_ARCH}.zip"

mkdir -p "$TOOLS_DIR"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fL "$DOWNLOAD_URL" -o "$TMP_DIR/tweego.zip"
unzip -q "$TMP_DIR/tweego.zip" -d "$TMP_DIR"

if [[ ! -f "$TMP_DIR/tweego" ]]; then
  echo "Error: Tweego binary not found in archive."
  exit 1
fi

cp "$TMP_DIR/tweego" "$TWEEGO_BIN"
chmod +x "$TWEEGO_BIN"

echo "Installed Tweego to: $TWEEGO_BIN"
echo "Build using: bash scripts/build.sh"
