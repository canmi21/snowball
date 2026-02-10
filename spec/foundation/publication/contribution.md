# Contribution

## Maintenance Model

The snowball ecosystem is maintained by a single maintainer
with final decision authority on all changes.

External contributions are welcome via pull requests.
All PRs must conform to the snowball specification.

## Pull Request Acceptance

A PR is accepted when it satisfies all of the following:

- Passes the full [pre-publish checklist](checklist.md).
- Conforms to the relevant specification files
  (architecture, patterns, practices, naming, documentation).
- Does not introduce unnecessary complexity or scope beyond the stated goal.
- The maintainer approves.

## Proposing a New Crate

A proposal for a new crate in the monorepo must explain:

1. **What problem it solves** — the specific X→Y transformation
   or capability it provides.
2. **Why existing crates are insufficient** — what gap exists
   in the current ecosystem.
3. **Where it fits** — its role (leaf, composition, convergence)
   and which crates it depends on or extends.

The proposal is a discussion, not a formal document.
An issue or PR description is sufficient.

## Code Style

All contributed code must follow the ecosystem's established rules:

- Formatting: `cargo fmt` (see [checklist](checklist.md)).
- Linting: `cargo clippy -- -D warnings` across the feature matrix.
- Documentation: every public item documented
  (see [doc-comments](../../lib/practices/documentation/doc-comments.md)).
- Patterns: the appropriate library pattern
  (see [patterns](../../lib/patterns/)).
- Error handling, naming, feature flags, observability:
  as defined in the respective specification files under
  [practices](../../lib/practices/).
- Commits and branching: as defined in
  [git](../git/commit-message.md).
