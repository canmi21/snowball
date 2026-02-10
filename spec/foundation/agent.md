# Agent

Rules for defining LLM sub-agents in the snowball ecosystem.

## File Location

- Project agents: `.claude/agents/`
- Naming: kebab-case, flat files only (no subdirectories).
  Use prefixes for categorization (`spec-review.md`, `spec-check.md`).
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

### Model Selection

| Model    | Use when                                                         |
| -------- | ---------------------------------------------------------------- |
| `opus`   | Deep reasoning, architecture decisions, complex multi-step tasks |
| `sonnet` | Standard tasks, code modification, search and analysis           |
| `haiku`  | Simple mechanical tasks, format checks, single-step operations   |

Avoid `inherit`. Choose the minimum model that handles the task.

## Body Content

- Concise but complete — every key point stated, no guessing.
- Point to spec files for rules instead of duplicating content.
  The agent reads spec dynamically; when the spec changes,
  the agent adapts automatically.
- If the spec does not cover a situation, the agent does not act.

## Memory

Stateless agents omit the memory section entirely.

When an agent needs to persist learning across sessions,
add `memory: project` to frontmatter and include a memory
section in the body that tells the agent its memory directory
exists at `.claude/agent-memory/{agent-name}/`.

The memory mechanism is provided by Claude Code.
The spec only defines when and how to reference it.
