#!/usr/bin/env bash
set -euo pipefail

HOOK_INPUT=$(cat)
FILE_PATH=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // ""')

[[ -z "$FILE_PATH" || ! -f "$FILE_PATH" ]] && exit 0

case "$FILE_PATH" in
    *.ts|*.tsx|*.js|*.jsx|*.vue)
        DIR=$(dirname "$FILE_PATH")
        while [[ "$DIR" != "/" ]]; do
            if [[ -f "$DIR/node_modules/.bin/prettier" ]]; then
                "$DIR/node_modules/.bin/prettier" --write "$FILE_PATH" 2>/dev/null || true
                jq -n '{
                    "hookSpecificOutput": {
                        "hookEventName": "PostToolUse",
                        "additionalContext": "File was auto-formatted by Prettier. Content may differ slightly from what you wrote."
                    }
                }'
                break
            fi
            DIR=$(dirname "$DIR")
        done
        ;;
    *.php)
        DIR=$(dirname "$FILE_PATH")
        while [[ "$DIR" != "/" ]]; do
            if [[ -f "$DIR/vendor/bin/php-cs-fixer" ]]; then
                "$DIR/vendor/bin/php-cs-fixer" fix "$FILE_PATH" --quiet 2>/dev/null || true
                jq -n '{
                    "hookSpecificOutput": {
                        "hookEventName": "PostToolUse",
                        "additionalContext": "File was auto-formatted by php-cs-fixer. Content may differ slightly from what you wrote."
                    }
                }'
                break
            fi
            DIR=$(dirname "$DIR")
        done
        ;;
esac

exit 0
