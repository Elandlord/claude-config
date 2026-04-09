---
allowed-tools: Bash, Read, Glob, Grep, Write, Edit, Agent, mcp__clickup__get_tasks, mcp__clickup__get_spaces, mcp__clickup__get_lists
description: Generate a structured sprint review from ClickUp, git, and other sources
---

Generate a structured sprint review document covering the last 2 weeks.

## Data Sources

1. **Git**: Run `git log --since='14 days ago' --oneline --all` across all repos in the monorepo (`~/documents/TestTwo/`) and any active home-directory projects (`~/claude-dashboard`, `~/claude-dashboard-api`, `~/claude-runner`). Summarize commits by project/service.

2. **ClickUp**: Use the ClickUp MCP tools to fetch completed tasks from the last 2 weeks. Group by space/list.

3. **PRs**: Run `gh pr list --state merged --search "merged:>=$(date -v-14d +%Y-%m-%d)" --json title,url,mergedAt,author` for each repo that has a GitHub remote.

## Output Format

Write the review to `~/Documents/sprint-reviews/sprint-review-{YYYY-MM-DD}.md` with this structure:

```markdown
# Sprint Review — {date range}

## Completed
- Bullet points grouped by project/service
- Include PR links where available

## In Progress
- Items started but not yet finished (from ClickUp or open PRs)

## Key Metrics
- PRs merged: N
- Commits: N
- Services touched: [list]

## Blockers / Risks
- Any stalled items or issues discovered
```

If a data source is unavailable (no ClickUp access, no GitHub remote), skip it and note it in the output. Do not fail — produce the best review possible with available data.
