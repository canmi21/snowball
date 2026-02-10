# Heuristics

## Philosophy

Numeric thresholds in the snowball ecosystem are design introspection
triggers, not hard limits. Reaching a threshold signals that evaluation
is needed — it does not mean the content is wrong.

As snowball grows, reaching these thresholds is a matter of when,
not if. The value of a threshold is in creating a checkpoint
where the author pauses to assess structure.

## Thresholds

| Threshold | Scope | Trigger |
|-----------|-------|---------|
| 100 lines | Spec file | Evaluate splitting into a directory with subfiles |
| 300 lines (SCoL) | Code module | Evaluate crate decomposition or module extraction |
| 4 levels | Directory nesting | Evaluate flattening or reorganization |

SCoL = Source Count of Lines, excluding comments, blank lines, and tests.

Each threshold is defined here. Other spec files link to this table
rather than restating the number.

## Evaluation

When a threshold is reached:

1. Identify whether the content has multiple distinct concerns.
2. If yes — split along concern boundaries.
3. If no — the content is cohesive and exceeding the threshold
   is acceptable.

The goal is cohesion, not numerical compliance.
A 120-line file with one clear purpose is better than
two 60-line files with an artificial split.

## Mechanical Checks

Shell scripts in [`tools/`](../../tools/) use these thresholds
as CI gate values. A threshold violation flags the change
for attention, not automatic rejection.

### Allowlist

Acknowledged violations are recorded in an allowlist file
at `tools/check/allowlist.toml`. Each entry contains:

- The file path.
- The check that is exceeded.
- A content hash of the file at the time of acknowledgment.
- The reason the violation is acceptable.

When the script encounters a violation, it checks the allowlist.
If the file hash matches, the violation is silently skipped.
If the file has been modified (hash mismatch), the entry is
invalidated and the violation is flagged again for re-evaluation.
