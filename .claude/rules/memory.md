# Project Memory

Detailed knowledge base lives in `.claude/memory/`. Read on demand.

| File              | Content                                                         |
| ----------------- | --------------------------------------------------------------- |
| `decisions.md`    | Architecture, error handling, panic policy, VCS, spec evolution |
| `workflow.md`     | Spec writing process, discussion granularity, commit workflow   |
| `vcs-decision.md` | jj/git model, bookmark strategy, repo topology, config table    |

## Always Remember

- Discussion: Chinese + English technical terms. Artifacts: English only
- `qwq fmt .` not `cargo fmt`. `qwq lint clippy` not `cargo clippy`. `qwq install .` not `cargo install`
- `qwq vcs diff` (no args) gives truncated diff (50/file, 1000 total) — enough for agents
- **Agent-first**: always check registry before doing work manually. If an agent fits, dispatch it — never do its job yourself
- **vcs-bot default = full**: dispatch without restrictions → commit+land+push. Say "commit only" etc. for selective mode
- **vcs-bot prompt phrasing**: describe _what changes to land_, never use "commit" as the action verb — it misleads into selective mode
- When working manually on a repeatable pattern, ask user if it should become an agent
- **Agent spec changed or created?** Proactively trigger handover — new session needed to load updated agent
- Discuss before writing spec — concept-level confirmation, not prose-level
- Don't add Co-Authored-By lines to commits
- User prefers tabs (hard_tabs, indent_size 2)
