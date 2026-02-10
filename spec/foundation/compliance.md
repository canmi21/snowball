# Compliance Checking

## Two Layers

Spec compliance is verified through two complementary layers.

### Layer 1 — Mechanical Checks (Shell Scripts)

Deterministic scripts that enforce rules expressible as pattern matching:

- Link validity across spec files.
- File line count (under 100 lines).
- File and directory naming (lowercase + hyphens).
- Forbidden patterns (`unwrap`, `expect`, `panic!`, emoji).
- Terminology consistency in the correct context.
- CHANGELOG format validation.

Commit message format is enforced at commit time by the commit
wrapper (`tools/git/commit.sh`), not as a post-hoc check.

Scripts run in CI as a gate. A failure blocks the action.

#### Script Modification as Breaking Signal

When a spec change requires modifying a checking script,
that is a natural signal that the change may be breaking.
The need to update mechanical checks forces explicit consideration
of impact — this is a feature, not overhead.

Adding a new script is additive and harmless.
Modifying an existing script's rules triggers review.

### Layer 2 — Semantic Checks (LLM Agent)

An LLM agent reads the current spec and checks for:

- Writing tone and style compliance.
- Cross-file logical consistency.
- Rule contradictions.
- Single source of truth violations.
- Spec gaps (rules that should exist but do not).

The agent reads the spec dynamically.
When the spec changes, the agent's checks adapt automatically
without manual update.

When the agent discovers a spec gap, it proposes an evolution
through the [evolution process](evolution/process.md).

### Relationship

| Property               | Shell Script  | LLM Agent |
| ---------------------- | ------------- | --------- |
| Deterministic          | Yes           | No        |
| Cost                   | Zero          | API cost  |
| Speed                  | Fast          | Slower    |
| CI gate                | Yes           | Optional  |
| Adapts to spec changes | Manual update | Automatic |
| Semantic understanding | No            | Yes       |

Layer 1 is the floor — minimum compliance, always enforced.
Layer 2 is the review — deeper compliance, run on demand.

## Script Location

Checking scripts live in the `tools/` directory at the monorepo root.
The `Makefile` at the repository root serves as the entry point
for running checks (see [directory](architecture/directory.md)).
