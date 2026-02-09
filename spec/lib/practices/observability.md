# Observability

## Core Principle

Libraries do not log. All information flows through return values and error types.
Observation and recording are the caller's policy, not the library's behavior.

## Zero Logging

The following are **forbidden** in library crates:

- `log::info!`, `log::debug!`, `log::warn!`, `log::error!`
- `println!`, `eprintln!`
- `tracing::info!`, `tracing::debug!`, `tracing::warn!`, `tracing::error!`

Event macros (`tracing::info!`, etc.) are disguised logging.
They push information to the caller without being asked — the same violation
as `println!`.

## Span Instrumentation — The One Exception

`#[instrument]` is allowed because it is **passive annotation**,
not active output. It marks "I am inside this function" and lets
the caller's tracing subscriber decide whether to collect the span.

### Rules

- `#[instrument]` must be behind an optional `tracing` feature flag.
- When the feature is disabled, there is zero runtime cost.

```toml
[features]
tracing = ["dep:tracing"]

[dependencies]
tracing = { version = "0.1", optional = true }
```

```rust
#[cfg_attr(feature = "tracing", tracing::instrument)]
pub async fn parse(&self, raw: &[u8]) -> Result<Output, Error> {
    // ...
}
```

This is particularly valuable for async crates, where traditional stack traces
are ineffective and spans are the primary debugging mechanism.
