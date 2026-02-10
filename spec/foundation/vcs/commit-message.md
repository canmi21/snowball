# Commit Message

## Format

```
type(scope): description

optional body
```

- Subject line: `type(scope): description`.
- Description starts with a lowercase letter, no trailing period.
- Subject line must not exceed 72 characters.
- Body is separated by a blank line. Keep it concise — state what changed, nothing more.
- Most commits in the snowball ecosystem should not need a body.
  The fine-grained crate structure makes the subject line sufficient.
- No footer section.

## Types

Eleven commit types, divided into two groups.

### CHANGELOG-Mapped

These types correspond directly to CHANGELOG categories
(see [format](../changelog/format.md)):

| Type     | CHANGELOG Category |
| -------- | ------------------ |
| `add`    | Added              |
| `fix`    | Fixed              |
| `change` | Changed            |
| `rm`     | Removed            |
| `break`  | Breaking           |

### Non-CHANGELOG

These types do not produce CHANGELOG entries:

| Type       | Purpose                                                           |
| ---------- | ----------------------------------------------------------------- |
| `refactor` | Code restructuring that does not change behavior                  |
| `doc`      | Documentation changes                                             |
| `test`     | Test additions or modifications                                   |
| `spec`     | Snowball spec changes                                             |
| `ci`       | CI/CD pipeline changes                                            |
| `chore`    | Trivial housekeeping — use sparingly, only when nothing else fits |

## Scope

The scope identifies the area of change:

- **Crate commits**: scope = crate name. Example: `fix(my-crate): handle empty input`.
- **Spec commits**: scope = spec area. Example: `spec(foundation): add vcs rules`.
- **Workspace-level commits**: scope = `workspace`. Example: `chore(workspace): update dependencies`.

See [commit-scope](commit-scope.md) for granularity rules.

## Cross-Crate Rule

A commit must not span multiple crates.
If a change touches more than one crate, split it into separate commits,
one per crate.

## Per-Domain Rules

Each domain adds its own constraints:

- Library crates: see [lib](lib.md).
- Binary crates: see [bin](bin.md).
- The spec itself: see [spec](spec.md).

## jj Workflow

All commits are created through jj, never through git directly.

- `jj commit -m "type(scope): description"` — snapshot the current
  working copy into a new commit and start a fresh change.
- `jj describe -m "type(scope): description"` — set or update the
  description of the current change without creating a new one.
- `jj split` — interactively split the current change into two
  when it contains unrelated modifications.

The commit message format applies identically regardless of
which jj command creates the commit.
