#!/usr/bin/env bash
set -euo pipefail

HOOK_INPUT=$(cat)
FILE_PATH=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // ""')

[[ -z "$FILE_PATH" ]] && exit 0

case "$FILE_PATH" in
    *.ts|*.tsx)
        DIR=$(dirname "$FILE_PATH")
        while [[ "$DIR" != "/" ]]; do
            if [[ -f "$DIR/node_modules/.bin/tsc" ]]; then
                ERRORS=$("$DIR/node_modules/.bin/tsc" --noEmit --pretty false 2>&1 | grep "$(basename "$FILE_PATH")" | head -5 || true)
                if [[ -n "$ERRORS" ]]; then
                    jq -n --arg errs "$ERRORS" '{
                        "hookSpecificOutput": {
                            "hookEventName": "PostToolUse",
                            "additionalContext": ("Type errors detected:\n" + $errs)
                        }
                    }'
                fi
                break
            fi
            DIR=$(dirname "$DIR")
        done
        ;;
esac

exit 0
