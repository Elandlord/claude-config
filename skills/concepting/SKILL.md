# Concepting — From Thoughts to Ideas to Tasks

Interactive concepting skill that captures ideas and pushes them to the Claude Dashboard via MCP. Different from `/brainstorming` (generic design exploration) — this skill is specifically for generating, capturing, and promoting ideas into the dashboard.

## Trigger

Use when the user wants to concept, generate ideas, explore possibilities, or think through a problem before creating tasks. Also use when the user says `/concepting`.

## Prerequisites

The `claude-dashboard` MCP server must be connected. Verify by calling `list_projects` — if it fails, tell the user to restart Claude Code.

## Workflow

### Phase 1: Context Gathering

1. Call `mcp__claude-dashboard__list_projects` to get all available projects
2. Ask the user: **"What are we brainstorming about?"** and **"Which projects does this touch?"**
3. If the topic relates to code, use Explore agents or Grep/Read to understand the current state of relevant repos

### Phase 2: Brainstorming (the core loop)

This is a **rapid-fire, low-friction conversation**. Your job is to:

- Generate ideas, riff on the user's input, suggest angles they haven't considered
- Challenge assumptions constructively
- Cross-pollinate between projects when relevant (e.g., "this pattern in wemma could also solve the jenny issue")
- Keep the energy high and the friction low
- Track ideas as they emerge in a running numbered list

**Format ideas as you go:**
```
💡 Ideas so far:
1. [idea title] — [one-line description] — [project(s)]
2. [idea title] — [one-line description] — [project(s)]
...
```

Update this list as new ideas surface. The user can say things like:
- "kill 3" → remove idea 3
- "merge 2 and 5" → combine ideas
- "expand on 4" → deep dive into one idea
- "that's enough" / "let's wrap up" → move to Phase 3

### Phase 3: Review & Promote

Present the final idea list and ask: **"Which ideas should we promote to the dashboard?"**

For each idea the user selects:
1. Call `mcp__claude-dashboard__create_idea` with:
   - `title`: the idea title
   - `description`: the one-line description, expanded with any context from the brainstorm
   - `projects`: UUIDs of the relevant projects (from the project list in Phase 1)
   - `tags`: inferred from the brainstorm topic
2. Ask if they want to promote it directly to a task: if yes, call `mcp__claude-dashboard__promote_idea`

### Phase 4: Summary

Show what was created:
```
✅ Created N ideas, promoted M to tasks:
- "Idea title" → idea (draft)
- "Idea title" → task (pending_plan) in Project X
```

## Rules

- Never skip Phase 2 — the brainstorm conversation is the whole point
- Don't make the user fill out forms — extract title, description, projects, and tags from the conversation naturally
- If the user mentions projects by name, match them to UUIDs from the project list (fuzzy match is fine: "webshop" → "Peterprint Webshop")
- Keep ideas atomic — one idea per entry, split compound ideas
- The user can brainstorm without promoting anything — not every session needs to produce tasks
- Cross-project brainstorming is a first-class feature — actively look for connections between projects
