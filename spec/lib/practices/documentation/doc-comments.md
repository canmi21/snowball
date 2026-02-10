# Doc Comments

Follows the general rules in [general](general.md).

## Library Crates

### Mandatory (All Phases, Including 0.x)

Every public item (function, type, trait, method) must have a `///` doc comment containing:

1. **One-line summary** — what it does.
2. **Error conditions** (if it returns `Result`) — which inputs or states
   produce which `Error` variants.
3. **Minimal example** (`/// # Examples` block) — also serves as a compile-time test.

```rust
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
```

### Enforced by Lint

```toml
[lints.rust]
missing_docs = "deny"
```

This lint is active from `0.x` onward. Discipline starts at the beginning,
not at stabilization.

### Clippy Doc Lints

The following clippy lints should be enabled to enforce doc quality:

```toml
[lints.clippy]
doc_markdown = "warn"
missing_errors_doc = "warn"
missing_panics_doc = "warn"
```

- `doc_markdown`: catches unformatted code references in prose.
- `missing_errors_doc`: requires `# Errors` section when returning `Result`.
- `missing_panics_doc`: requires `# Panics` section when a function can panic.

## Binary Crates

- `main.rs` — no doc comments needed.
- `run.rs` — `run()` function needs a brief description of its orchestration role.
- `config.rs` — every field of the configuration struct must document
  its meaning and default value.
- `telemetry.rs` — document the replaceable subscriber strategy.

## Forbidden

- Doc comments on private functions (unless the logic is non-obvious).
- Implementation details in doc comments.
