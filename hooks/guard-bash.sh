#!/usr/bin/env bash
set -euo pipefail

HOOK_INPUT=$(cat)
COMMAND=$(echo "$HOOK_INPUT" | jq -r '.tool_input.command // ""')

if echo "$COMMAND" | grep -qE '(npm run dev|npm start|yarn dev|nuxt dev|vite|next dev|php artisan serve)'; then
    if [[ -z "${TMUX:-}" ]]; then
        echo "Dev servers must run in tmux to avoid context consumption. Run: tmux new -s dev" >&2
        exit 2
    fi
fi

exit 0
