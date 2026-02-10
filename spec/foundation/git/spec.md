# Git — Spec

Follows the shared rules in [commit-message](commit-message.md),
[commit-scope](commit-scope.md), and [branching](branching.md).

## Additional Rules

### Commit Type

Spec changes use the `spec` type exclusively.

### Scope

Scope matches the spec area:

- `spec(foundation)` — foundation-level rules.
- `spec(lib)` — library crate rules.
- `spec(bin)` — binary crate rules.

### Breaking Changes

A spec breaking change must follow the
[evolution process](../evolution/process.md)
before being committed.
The commit body references the evolution trigger
and impact assessment.
