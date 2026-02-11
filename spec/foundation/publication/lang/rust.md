# Publication — Rust

Rust-specific practices for the publication specifications
under [publication](../).

## Pre-Publish Checklist

Full Rust checklist: see [checklist](../checklist.md).

Steps use these tools:

1. `qwq fmt .`
2. `qwq lint clippy` (across feature matrix)
3. `cargo test`
4. `cargo doc --no-deps`
5. Zero `TODO`/`FIXME` markers
6. Version in `Cargo.toml` updated
7. CHANGELOG entry present
8. `cargo audit` passes
9. Dependencies published to crates.io in order

## Contribution Code Style

From the [contribution](../contribution.md) rules:

- Formatting: `qwq fmt`
- Linting: `qwq lint clippy`
- Documentation: every public item has doc comments
