# CHANGELOG — Specification

Follows the shared format in [format](format.md).

## Category Restrictions

All five categories are permitted at any time.
The spec is a living document that continuously adapts and refines itself.

However, Breaking changes must be used with caution and deliberation.

## Additional Requirements

### Breaking Entries

Every Breaking entry must:

- Reference the migration plan defined through the
  [evolution process](../evolution/process.md).
- List the affected spec files.

```markdown
### Breaking
- Changed the CHANGELOG categories from 6 to 5.
  Affected: `foundation/changelog/format.md`.
  Migration: [evolution/impact.md](../evolution/impact.md).
```

### All Entries

Every entry should list the spec files that were modified,
so that readers can quickly navigate to the changed content.

```markdown
### Added
- Spec evolution rules. Files: `foundation/evolution/triggers.md`,
  `types.md`, `process.md`, `impact.md`.
```

## Header

The spec CHANGELOG uses a slightly different preamble
since it documents the specification, not a crate:

```markdown
# Changelog

All notable changes to the snowball specification
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
adapted for the [snowball ecosystem](format.md).
```
