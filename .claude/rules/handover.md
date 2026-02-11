# Handover Protocol

When the user says "handover":

## Step 1: Update Memory

Review what happened this session and update `.claude/memory/` files:

- Fix any stale information (deleted files, renamed commands, new decisions)
- Add new decisions, patterns, or lessons learned
- Keep files concise — facts only, no session narrative

## Step 2: Output Handover Context

Compose the handover block and copy it to the macOS clipboard via `pbcopy`.
After copying, stop and tell the user "Handover copied to clipboard."
The user will restart the session and paste it.

Template:

```
Handover Context

## Repo State
- Monorepo branch, latest commits, clean/dirty
- app/qwq branch, latest commits, clean/dirty

## What Was Done
- Bullet list of completed work this session

## Pending
- Next steps, unfinished items, known issues

## Memory Updated
- List which `.claude/memory/` files were touched

---
Start by reading `.claude/rules/` (auto-loaded) and `.claude/memory/` files
to sync up, then continue from Pending items.
```

Keep the handover context compact — enough to orient the next session,
not a full replay. The detailed knowledge is in memory files.
