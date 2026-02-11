# Workflow

## Spec Writing Process

1. User requests a new spec area
2. Present concept outline (file layout + section summaries) → user confirms
3. Go through each file's concepts, present options → user selects or adds info
4. Write confirmed content into files
5. Self-review: spec audits itself against its own rules
6. Fix issues through the same option-based flow
7. Dispatch vcs-bot: diff → commit → land → push (one call)

## Discussion Granularity

- Don't ask per-paragraph — ask per-file concept outline
- Don't dump full file drafts — present bullet-point concepts, confirm, then write
- User prefers to confirm concepts, not prose

## Spec Modification

- **Always use spec-bot** for spec file changes (modify mode → auto cascade → auto check)
- spec-bot handles: edit content, update README index, CHANGELOG, VERSION, CLAUDE.md, format, compliance
- For semantic review: dispatch spec-review agent first, then fix findings via spec-bot

## Self-Review Cycle (Evolution Loop)

1. Dispatch spec-review agent → report findings
2. Discuss critical/important findings with user
3. Fix confirmed items via spec-bot (modify mode)
4. The fixed spec becomes the new standard for the next review

## Commit Workflow

- Dispatch vcs-bot with the full sequence needed (e.g., "diff, commit, land, push")
- vcs-bot can start from any step — tell it exactly which steps to run
- Default for completed work: diff → commit → land → push (one dispatch, save context)
- Agent uses `qwq vcs` commands exclusively (never raw jj/git)
- Cross-area rule: definition commit + chore(workspace) cascade commit

## Spec Version Update

Handled automatically by spec-bot cascade mode (VERSION + CHANGELOG + format).

## When User Says...

- "讨论一下" → discuss best practices, don't just write
- "写回" / "写吧" → user confirmed, write the files
- "review" → run self-review cycle on all spec files
- "commit" → dispatch vcs-bot (diff → commit → land → push)
- "最佳实践是什么" → analyze tradeoffs, present recommendation with reasoning
