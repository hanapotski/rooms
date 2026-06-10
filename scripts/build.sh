#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MINIGAMES_DIR="$ROOT_DIR/minigames"
DIST_DIR="$ROOT_DIR/dist"
OUTPUT_FILE="$DIST_DIR/index.html"
LOCAL_TWEEGO="$ROOT_DIR/.tools/tweego"
STORYFORMAT_ID="sugarcube-2.37.3"
STORYFORMAT_DIR="$ROOT_DIR/.storyformats/$STORYFORMAT_ID"
STORYFORMAT_FILE="$STORYFORMAT_DIR/format.js"
STORYFORMAT_URL="https://twinery.org/2/story-formats/sugarcube-2.37.3/format.js"

TWEEGO_BIN=""
if command -v tweego >/dev/null 2>&1; then
  TWEEGO_BIN="$(command -v tweego)"
elif [[ -x "$LOCAL_TWEEGO" ]]; then
  TWEEGO_BIN="$LOCAL_TWEEGO"
fi

if [[ -z "$TWEEGO_BIN" ]]; then
  cat <<'MSG'
Error: tweego is not installed.

Install Tweego locally for this repo:
  bash scripts/install-tweego.sh

Or install globally from releases:
  https://github.com/tmedwards/tweego/releases
MSG
  exit 1
fi

if [[ ! -f "$STORYFORMAT_FILE" ]]; then
  echo "SugarCube format not found locally; downloading $STORYFORMAT_ID..."
  mkdir -p "$STORYFORMAT_DIR"
  curl -fL "$STORYFORMAT_URL" -o "$STORYFORMAT_FILE"
fi

if [[ ! -d "$MINIGAMES_DIR" ]]; then
  echo "Error: minigames directory not found: $MINIGAMES_DIR"
  exit 1
fi

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

SOURCE_FILES=()
while IFS= read -r file; do
  SOURCE_FILES+=("$file")
done < <(find "$MINIGAMES_DIR" -type f -name '*.twee' | sort)

if [[ ${#SOURCE_FILES[@]} -eq 0 ]]; then
  echo "Error: no .twee source files found under $MINIGAMES_DIR"
  exit 1
fi

# Compile all mini-game source files into one deployable game.
"$TWEEGO_BIN" -f "$STORYFORMAT_ID" -o "$OUTPUT_FILE" "${SOURCE_FILES[@]}"

echo "Built: $OUTPUT_FILE"
