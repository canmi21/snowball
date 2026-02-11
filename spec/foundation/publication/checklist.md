# Pre-Publish Checklist

Every crate must pass the following checks before publishing to crates.io.
Execute in order. A failure at any step blocks publication.

## 1. Formatting

```
qwq fmt --check .
```

All code must conform to the project's formatting configuration.

## 2. Lint (Feature Matrix)

```
qwq lint
```

Run clippy (via `qwq lint`) against every meaningful feature combination.
If a crate defines feature flags, all valid combinations must produce
zero clippy warnings. At minimum:

- Default features
- No default features (`--no-default-features`)
- All features (`--all-features`)
- Each individual feature in isolation, if the features are independent

A crate cannot be published if any feature combination produces a warning.

## 3. Tests

```
cargo test
```

All tests pass. This includes unit tests, integration tests,
and doc tests.

## 4. Documentation

```
cargo doc --no-deps
```

Zero warnings. Every public item has a doc comment
(see [doc-comments](../../lib/practices/documentation/doc-comments.md)).

## 5. No Remaining Markers

Zero `TODO` and `FIXME` markers in the crate source.
These are development-time reminders and must be resolved before publication
(see [code-comments](../../lib/practices/documentation/code-comments.md)).

## 6. Version Number

The version in `Cargo.toml` has been updated and follows semver
(see [versioning](versioning.md)).

## 7. CHANGELOG

The CHANGELOG includes an entry for the new version
describing what changed and why
(see [changelog format](../changelog/format.md)).

## 8. Dependency Audit

```
cargo audit
```

Zero known vulnerabilities in the dependency tree
(see [dependency safety](../safety/dependency.md)).

## 9. Dependencies Published

If this crate depends on new versions of other monorepo crates,
those crates must already be published to crates.io.
Publish in dependency order: leaves first, compositions next,
convergence last.
