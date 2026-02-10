# CHANGELOG Format

Based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
adapted for the snowball ecosystem.

## File

- File name: `CHANGELOG.md`, placed at the crate root directory.
- Language: English, declarative sentences.
- Ordering: newest version first.

## Header

Every CHANGELOG begins with this preamble:

```markdown
# Changelog

All notable changes to this crate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
adapted for the [snowball ecosystem](spec/foundation/changelog/format.md).
```

The third link points to this file. Adjust the relative path
to match the crate's location in the repository.

## Unreleased Section

An `## [Unreleased]` section sits between the header and the first
versioned entry. It collects changes that have not yet been published.
On publication, the Unreleased contents move into a new versioned entry
and the Unreleased section is emptied.

## Version Entry Format

```markdown
## [0.2.0] - 2025-03-15

### Added
- `encode` function for the reverse transformation.

### Fixed
- Incorrect handling of empty input returning Ok instead of error.
```

- Version number in brackets, followed by a dash and the date.
- Date format: ISO 8601 (`YYYY-MM-DD`).
- Each change is one line, concise and complete.

## Five Categories

| Category | Meaning |
|----------|---------|
| **Added** | New functionality. |
| **Fixed** | Bug fixes. |
| **Changed** | Modifications to existing functionality (non-breaking). |
| **Removed** | Removed functionality. |
| **Breaking** | Changes that break backward compatibility. |

Only include categories that have entries. Omit empty categories.

The order within a version entry is: Breaking, Added, Changed, Fixed, Removed.
Breaking appears first to maximize visibility.

## No Comparison Links

In the snowball monorepo, version comparison links at the bottom of the file
are not used. The CHANGELOG text itself documents all changes.

## Per-Domain Rules

Each domain adds its own constraints on which categories
are permitted in which lifecycle phase:

- Library crates: see [lib](lib.md).
- Binary crates: see [bin](bin.md).
- The spec itself: see [spec](spec.md).
