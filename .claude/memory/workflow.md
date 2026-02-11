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

## Self-Review Cycle (Evolution Loop)
1. Read all spec files
2. Check against spec's own rules (writing-style, structure, terminology, links)
3. Report findings categorized by severity (critical/important/minor)
4. Ask user for each fix, present options
5. Fix confirmed items
6. Write discovered gaps back into spec
7. The fixed spec becomes the new standard for the next review

## Commit Workflow
- Dispatch vcs-bot with the full sequence needed (e.g., "diff, commit, land, push")
- vcs-bot can start from any step — tell it exactly which steps to run
- Default for completed work: diff → commit → land → push (one dispatch, save context)
- Agent uses `qwq vcs` commands exclusively (never raw jj/git)
- Cross-area rule: definition commit + chore(workspace) cascade commit

## Spec Version Update
After any spec change:
```bash
date -u +"%Y-%m-%dT%H:%M:%SZ" > spec/VERSION
```
Then update spec CHANGELOG.

## When User Says...
- "讨论一下" → discuss best practices, don't just write
- "写回" / "写吧" → user confirmed, write the files
- "review" → run self-review cycle on all spec files
- "commit" → dispatch vcs-bot (diff → commit → land → push)
- "最佳实践是什么" → analyze tradeoffs, present recommendation with reasoning
