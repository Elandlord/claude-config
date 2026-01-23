#!/usr/bin/env bash
set -euo pipefail

HOOK_INPUT=$(cat)
FILE_PATH=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // ""')

if [[ "$FILE_PATH" == *.md ]] && ! echo "$FILE_PATH" | grep -qE '(README|CHANGELOG|docs/|\.claude/)'; then
    echo "Creating markdown files outside docs/README/CHANGELOG/.claude is blocked." >&2
    exit 2
fi

exit 0
