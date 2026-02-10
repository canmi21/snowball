# VCS — Library Crates

Follows the shared rules in [commit-message](commit-message.md),
[commit-scope](commit-scope.md), and [bookmarks](bookmarks.md).

## Additional Rules

### Version Bump

A version bump is a standalone commit:

```
change(my-lib): bump to v0.1.2
```

Do not combine version bumps with code changes.
CHANGELOG updates may be included in the same commit as the version bump.

### CHANGELOG-Mapped Types After 1.0

- In 0.x: all five CHANGELOG-mapped types are available.
- After 1.0: only `add` and `fix` are permitted as CHANGELOG-mapped types.
  `change`, `rm`, and `break` are forbidden,
  matching the [CHANGELOG restriction](../changelog/lib.md).
- Non-CHANGELOG types (`refactor`, `doc`, `test`, `ci`, `chore`)
  are unaffected by lifecycle phase.
