# Safety — Rust

Rust-specific practices for the safety specifications
under [safety](../).

## Panic Policy

Forbidden operations from the [panic policy](../panic-policy.md):

- `.unwrap()`
- `.expect()`
- `panic!()`
- `unreachable!()` without a proven invariant
- `todo!()` in published code

Error propagation uses `Result` and `?`.

Clippy enforcement in workspace `Cargo.toml`:

```toml
[workspace.lints.clippy]
unwrap_used = "deny"
expect_used = "deny"
panic = "deny"
todo = "deny"
unimplemented = "deny"
```

## Unsafe Code

Full Rust-specific policy: see [unsafe-code](../unsafe-code.md).

## Dependency Audit

Audit tool for the [dependency safety](../dependency.md) policy:

```
cargo audit
```

Run before every publication. Zero known vulnerabilities required.
