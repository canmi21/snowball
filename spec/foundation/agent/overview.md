# Agent

Rules for defining LLM sub-agents in the snowball ecosystem.

## File Location

- Project agents: `.claude/agents/`
- Naming: kebab-case, flat files only (no subdirectories).
  Use prefixes for categorization (`spec-bot.md`, `spec-review.md`).
- File name matches the `name` field in frontmatter.

## Frontmatter

Every agent file begins with YAML frontmatter:

```yaml
---
name: example-agent
description: "when and what to use, short but clear"
tools: Read, Grep, Glob
model: sonnet
---
```

### Required Fields

| Field         | Rule                                    |
| ------------- | --------------------------------------- |
| `name`        | Unique identifier, matches file name    |
| `description` | When to use this agent, concise         |
| `tools`       | Only the tools the agent actually needs |
| `model`       | Select by task complexity (see below)   |

See [model selection](model-selection.md) for model rules.

## Body Content

- Concise but complete — every key point stated, no guessing.
- Point to spec files for rules instead of duplicating content.
  The agent reads spec dynamically; when the spec changes,
  the agent adapts automatically.
- If the spec does not cover a situation, the agent stops
  and reports the gap (see [first rule](first-rule.md)).

## Memory

Stateless agents omit the memory section entirely.

When an agent needs to persist learning across sessions,
add `memory: project` to frontmatter and include a memory
section in the body that tells the agent its memory directory
exists at `.claude/agent-memory/{agent-name}/`.

The memory mechanism is provided by Claude Code.
The spec only defines when and how to reference it.

## Prohibited Actions

- Agents must never invoke the `claude` CLI.
  Agents are already subprocesses of the orchestrator.
  Calling `claude` from within an agent creates recursive dispatch.

This is a universal rule that applies to all agents regardless of their tool access.
