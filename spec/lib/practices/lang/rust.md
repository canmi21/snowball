# Library Practices — Rust

Rust-specific implementation details for the library
[practices](../).

## Error Handling

From the [error handling](../error-handling.md) rules:

### Error Type

```rust
#[non_exhaustive]
#[derive(Debug, thiserror::Error)]
pub enum Error {
    #[error("invalid syntax at position {position}")]
    InvalidSyntax { position: usize },
}
```

- `#[non_exhaustive]` — ensures extensibility across minor versions.
- `thiserror` — the designated derive macro for all library error types.
- `#[source]` — links underlying causes in the error chain.

### Forbidden Error Carriers

`Box<dyn Error>`, `anyhow::Error`, `String` are forbidden
in library public APIs. `anyhow` is an application-layer privilege.

### Cross-Crate Conversions

`From` conversions between different crates' errors
are written only in composition crates, never in leaf crates.
All async error variants must be `Send + Sync`.

## Feature Flags

From the [feature flag](../feature-flag.md) rules:

### Capability Tiers

```toml
[features]
default = ["std"]
std = ["alloc"]
alloc = []
```

`no_std` is the implicit result of `default-features = false`.
See [no-std](../no-std.md).

### Convergence Selection

```toml
[features]
default = ["toml"]
toml = ["dep:config-parse-toml"]
json = ["dep:config-parse-json"]
```

### Mutual Exclusivity Enforcement

```rust
#[cfg(all(feature = "backend-a", feature = "backend-b"))]
compile_error!("features `backend-a` and `backend-b` are mutually exclusive");
```

### Behavioral Branching

`if cfg!(feature = "x") { ... } else { ... }` is forbidden
in leaf or composition crates.

## Observability

From the [observability](../observability.md) rules:

### Forbidden Calls

- `log::info!`, `log::debug!`, `log::warn!`, `log::error!`
- `println!`, `eprintln!`
- `tracing::info!`, `tracing::debug!`, `tracing::warn!`, `tracing::error!`

### Span Instrumentation

```toml
[features]
tracing = ["dep:tracing"]
[dependencies]
tracing = { version = "0.1", optional = true }
```

```rust
#[cfg_attr(feature = "tracing", tracing::instrument)]
pub async fn parse(&self, raw: &[u8]) -> Result<Output, Error> { /* ... */ }
```

## Testing

Test-only dependencies use `[dev-dependencies]` in `Cargo.toml`.
Recommended: `quinn` (QUIC), `hyper` (HTTP), `testcontainers` (DB).
