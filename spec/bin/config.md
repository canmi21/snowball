# Configuration

## Priority (Highest to Lowest)

1. **CLI arguments** — explicit user intent, highest trust.
2. **Configuration file** — persistent, auditable settings.
3. **Environment variables** — lowest priority due to injection risk
   in shared or containerized environments.

A value set by a higher-priority source is never overridden
by a lower-priority source.

## config.rs Responsibilities

- Define configuration as strongly typed structs. No `HashMap<String, String>`.
- Provide a `load()` function that merges sources in priority order
  and returns `anyhow::Result<Config>`.
- All validation completes inside `load()`.
  If `load()` returns `Ok`, the configuration is fully valid.

## The load() Boundary

`load()` is a transformation boundary.

Internally, the loading process may use dynamic structures
(`HashMap`, `serde_json::Value`, or any intermediate representation)
for merging, overlaying, and key lookup.
These are implementation details of the config parsing mechanism.

The output — the `Config` struct returned by `load()` — is always
a strongly typed, fully validated value.
Everything downstream of `load()` sees only the typed struct.

## Structural Rules

- Configuration structs are pure data: `#[derive(Debug, Clone)]`,
  no methods, no behavior.
- Nest by subsystem. Flat top-level structs with dozens of fields are forbidden.

```rust
#[derive(Debug, Clone)]
pub struct Config {
    pub server: ServerConfig,
    pub database: DatabaseConfig,
    pub telemetry: TelemetryConfig,
}
```

- Sensitive fields (passwords, tokens) must not appear in `Debug` output.
  Either exclude them from `Debug` or implement a custom `Debug`
  that redacts the value.

## Failure Semantics

Configuration loading failure prevents startup.
Silent fallback to default values is forbidden.

If a field has a meaningful default, express it in the struct definition
(e.g., `#[serde(default = "...")]`) so the default is explicit and auditable,
not hidden in fallback logic.

## Implementation

This specification defines behavioral requirements.
The snowball ecosystem will provide config crates that satisfy these requirements.
Binary crates are expected to use the ecosystem's config solution
when available, though the spec does not bind to a specific library.
