# Telemetry

Applies primarily to long-running services. CLI tools may opt in.

## Design Principle

The tracing subscriber is a replaceable component.
Different environments use different subscribers.

## Two-Step Initialization

Telemetry initializes in two steps to ensure that errors during
configuration loading are observable.

### Step 1 — Basic Init (before config)

Start a minimal subscriber using environment variables (`RUST_LOG`)
and default formatting. This captures any errors that occur
during the configuration loading phase.

### Step 2 — Reconfigure (after config)

Once configuration is loaded, reconfigure the subscriber
with the full telemetry settings from config
(output format, level overrides, export targets).

For CLI tools, step 2 may be omitted if `RUST_LOG` is sufficient.

## telemetry.rs Responsibilities

Construct, install, and reconfigure the global tracing subscriber:

```rust
pub fn init() -> (ReloadHandle, impl Drop) {
    // Build minimal subscriber with reload capability
    // Set as global default
    // Return reload handle + flush-on-drop guard
}

pub fn reconfigure(handle: &ReloadHandle, config: &TelemetryConfig) {
    // Apply full configuration to the running subscriber
}
```

Alternatively, provide named constructors for distinct environments:

```rust
pub fn init_production() -> (ReloadHandle, impl Drop) { ... }
pub fn init_test() -> impl Drop { ... }
```

## Rules

- Subscriber construction logic lives only in `telemetry.rs`.
- main.rs calls `init()` and `reconfigure()`. It does not know subscriber internals.
- Production: structured output (JSON or `key=value`).
- Development: human-readable output.
- Log level is controlled via `RUST_LOG` environment variable
  or configuration, never hardcoded.

## Relationship to Library Observability

- Library crates produce zero log output
  (see [observability](../lib/practices/observability.md)).
- Library crates may annotate functions with `#[instrument]`
  behind an optional `tracing` feature flag.
- The binary's subscriber activation is what makes
  library-level `#[instrument]` spans observable.
