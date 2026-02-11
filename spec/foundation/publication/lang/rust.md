# Publication — Rust

Rust-specific practices for the publication specifications
under [publication](../).

## Pre-Publish Checklist

Full Rust checklist: see [checklist](../checklist.md).

Rust tool commands for each step:

| Step                | Command               |
| ------------------- | --------------------- |
| 1. Formatting       | `qwq fmt .`           |
| 2. Lint             | `qwq lint clippy`     |
| 3. Tests            | `cargo test`          |
| 4. Documentation    | `cargo doc --no-deps` |
| 8. Dependency audit | `cargo audit`         |

Steps 5, 6, 7, 9 have no Rust-specific tooling — follow the [checklist](../checklist.md) descriptions directly.

## Contribution Code Style

From the [contribution](../contribution.md) rules:

- Formatting: `qwq fmt`
- Linting: `qwq lint clippy`
- Documentation: every public item has doc comments
