# Project Memory

Detailed knowledge base lives in `.claude/memory/`. Read on demand.

| File | Content |
|------|---------|
| `decisions.md` | Architecture, error handling, panic policy, VCS, spec evolution |
| `workflow.md` | Spec writing process, discussion granularity, commit workflow |
| `vcs-decision.md` | jj/git model, bookmark strategy, repo topology, config table |

## Always Remember

- Discussion: Chinese + English technical terms. Artifacts: English only
- `qwq fmt .` not `cargo fmt`. `qwq lint clippy` not `cargo clippy`. `qwq install .` not `cargo install`
- `qwq vcs diff` (no args) gives truncated diff (50/file, 1000 total) — enough for agents
- Dispatch agents for their tasks. vcs-bot handles all VCS operations (diff/commit/land/push)
- Discuss before writing spec — concept-level confirmation, not prose-level
- Don't add Co-Authored-By lines to commits
- User prefers tabs (hard_tabs, indent_size 2)
