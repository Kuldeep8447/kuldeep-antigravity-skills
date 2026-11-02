#!/bin/bash
set -e

echo "====================================================="
echo "   Kuldeep Antigravity Skills Auto-Installer (Unix)  "
echo "====================================================="

TARGET_DIR="${1:-$PWD/.agents/skills}"

if [ "$1" = "--global" ]; then
    TARGET_DIR="$HOME/.gemini/config/skills"
fi

echo "Installing skills into: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

COUNT=0
for skill in "$SKILLS_DIR"/*; do
    if [ -d "$skill" ]; then
        skill_name="$(basename "$skill")"
        cp -r "$skill" "$TARGET_DIR/$skill_name"
        COUNT=$((COUNT + 1))
    fi
done

echo "Successfully installed $COUNT skills into $TARGET_DIR!"
echo "Happy coding with Antigravity!"
