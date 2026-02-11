---
name: handover
description: "Session handover protocol. Use when the user says 'handover' or wants to transfer context to a new session."
---

# Handover

Transfer session context so the next session can continue seamlessly.

## Repo State (auto-injected)

### Monorepo

Recent commits:

!`jj log --no-graph --limit 5 -T 'change_id.shortest(8) ++ " " ++ if(bookmarks, bookmarks ++ " ", "") ++ description.first_line() ++ "\n"' 2>/dev/null || git log --oneline -5 2>/dev/null`

Working tree:

!`jj status 2>/dev/null || git status --short 2>/dev/null`

### app/qwq

Recent commits:

!`cd app/qwq && jj log --no-graph --limit 3 -T 'change_id.shortest(8) ++ " " ++ if(bookmarks, bookmarks ++ " ", "") ++ description.first_line() ++ "\n"' 2>/dev/null || echo "(not initialized)"`

Working tree:

!`cd app/qwq && jj status 2>/dev/null || echo "(not initialized)"`

### Memory files

!`ls .claude/memory/ 2>/dev/null || echo "(none)"`

## Step 1: Update Memory

Review the session and update `.claude/memory/` files:

- Fix stale information (deleted files, renamed commands, new decisions)
- Add new decisions, patterns, or lessons learned
- Keep concise — facts only, no session narrative

## Step 2: Compose and Copy

Compose a handover block following the template below,
then pipe it to `pbcopy` via Bash.

After copying, tell the user: "Handover copied to clipboard."

Template:

```
Handover Context

## Repo State
- Monorepo: <branch> @ <short-hash>, <clean/dirty>
- app/qwq: <branch> @ <short-hash>, <clean/dirty>

## What Was Done
- <bullet list of completed work>

## Pending
- <next steps, unfinished items, known issues>

## Memory Updated
- <which .claude/memory/ files were touched>

---
Start by reading `.claude/rules/` (auto-loaded) and `.claude/memory/` files
to sync up, then continue from Pending items.
```
