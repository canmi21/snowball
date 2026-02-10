# Versioning

Builds on the semver principles defined in [lifecycle](../lifecycle.md).
This document covers operational details.

## 0.x — Exploration Phase

- Breaking changes are expected.
- Each breaking change bumps the minor version: 0.1.0 → 0.2.0.
- Non-breaking additions and fixes bump the patch version: 0.1.0 → 0.1.1.
- No pre-release suffixes (`-alpha`, `-beta`, `-rc`). The 0.x version range
  itself signals instability. Full testing before every publish
  ensures quality without pre-release labels.

## 1.0 — Stability Commitment

Entering 1.0 means the API is stable. This decision is made by the maintainer
after the crate has been validated through actual usage in at least one
production or near-production context.

There is no quantitative threshold (e.g., "N users" or "M months").
The criterion is the maintainer's confidence that the public API
will not need breaking changes.

## 1.x+ — Additive Only

- Bug fixes: bump patch. 1.0.0 → 1.0.1.
- New public API (backward-compatible): bump minor. 1.0.0 → 1.1.0.
- Breaking changes: forbidden. Growth comes from new crates,
  not modification of stable ones (see [lifecycle](../lifecycle.md)).
- Major version is never bumped. A crate at 1.x stays at 1.x for its lifetime.

## Dependency Version Updates

When a crate updates its dependency on another monorepo crate:

- If the dependency's new version is a minor bump (new API):
  the dependent crate bumps its own minor version.
- If the dependency's new version is a patch bump (bug fix):
  the dependent crate bumps its own patch version.
