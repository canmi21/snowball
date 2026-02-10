# Documentation — Rust

Rust-specific documentation practices for the
[documentation](../) specifications.

## Doc Comments

From the [doc comments](../doc-comments.md) rules:

````rust
/// Parses raw bytes into a configuration structure.
///
/// # Errors
///
/// - [`ParseError::InvalidSyntax`] — input is not valid TOML.
/// - [`ParseError::MissingField`] — a required field is absent.
///
/// # Examples
///
/// ```
/// let config = my_lib::parse(b"key = \"value\"")?;
/// assert_eq!(config.get("key"), Some("value"));
/// # Ok::<(), my_lib::ParseError>(())
/// ```
pub fn parse(raw: &[u8]) -> Result<Config, ParseError> { /* ... */ }
````

### Enforced by Lint

```toml
[lints.rust]
missing_docs = "deny"
```

Active from `0.x` onward.

### Clippy Doc Lints

```toml
[lints.clippy]
doc_markdown = "warn"
missing_errors_doc = "warn"
missing_panics_doc = "warn"
```

- `doc_markdown`: catches unformatted code references in prose.
- `missing_errors_doc`: requires `# Errors` section when returning `Result`.
- `missing_panics_doc`: requires `# Panics` section when a function can panic.

## Code Comments

From the [code comments](../code-comments.md) rules:

### SAFETY Annotations

Required by clippy (`undocumented_unsafe_blocks`) before every `unsafe` block.

Format: `// SAFETY:` followed by a declarative sentence explaining
why the unsafe operation is sound — which invariants are upheld
and how they are guaranteed.

```rust
// SAFETY: The pointer is non-null because it was obtained from Box::into_raw
// and has not been deallocated since.
unsafe { *ptr }
```

The sentence must be specific to this call site.
Generic statements like "this is safe" or "the caller guarantees safety"
are not acceptable.

See [unsafe-code](../../../../foundation/safety/unsafe-code.md)
for the full unsafe code policy.

### TODO / FIXME Syntax

```rust
// TODO: Handle the case where the connection is reset mid-transfer.
```
