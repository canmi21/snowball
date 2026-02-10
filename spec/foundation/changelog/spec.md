# CHANGELOG — Specification

## Versioning

The spec does not use semver. Revisions are identified by UTC timestamps.
Each modification produces a new timestamp obtained via:

```bash
date -u +"%Y-%m-%dT%H:%M:%SZ"
```

The current spec version is stored in [VERSION](../../VERSION).

## Category Restrictions

All five categories are permitted at any time.
The spec is a living document that continuously adapts and refines itself.

However, Breaking changes must be used with caution and deliberation.

## Unreleased Section

The spec CHANGELOG does not use an `[Unreleased]` section.
Every spec modification produces an immediate timestamp version,
so there is no unreleased state.

## Version Entry Format

```markdown
## [2026-02-10T06:11:23Z]

### Added

- VCS specification. Files: `foundation/vcs/strategy.md`,
  `shared-config.md`, `commit-message.md`, `commit-scope.md`,
  `bookmarks.md`, `lib.md`, `bin.md`, `spec.md`.

### Fixed

- Convergence rules duplicated in roles.md and convergence.md.
  Files: `foundation/architecture/roles.md`.
```

The timestamp is the version. No separate date field.

## Additional Requirements

### Breaking Entries

Every Breaking entry must:

- Reference the migration plan defined through the
  [evolution process](../evolution/process.md).
- List the affected spec files.

### All Entries

Every entry should list the spec files that were modified,
so that readers can quickly navigate to the changed content.

## Header

```markdown
# Changelog

All notable changes to the snowball specification
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
adapted for the [snowball ecosystem](format.md).
Spec revisions use UTC timestamps as version identifiers.
```

## Spec Version Tracking

Each crate that follows the snowball spec should record
which spec version it was last aligned with.
When the spec updates, compare the recorded version against
the spec CHANGELOG to determine what changed and whether
the crate needs adjustment.
