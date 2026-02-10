# Binary Crate — Rust

Rust-specific implementation details for the binary crate
specifications under [bin](../).

## Dependency Assembly

From the [assembly](../assembly.md) rules:

```rust
async fn run(config: Config) -> anyhow::Result<()> {
    let db = Database::connect(&config.database).await?;
    let user_service = UserService::new(db.clone());
    let auth_service = AuthService::new(db.clone());
    let app = App::new(user_service, auth_service);
    app.start().await
}
```

Global state (`static`, `lazy_static`, `OnceLock` for services) is forbidden.

## Configuration

From the [config](../config.md) rules:

```rust
#[derive(Debug, Clone)]
pub struct Config {
    pub server: ServerConfig,
    pub database: DatabaseConfig,
    pub telemetry: TelemetryConfig,
}
```

- `load()` returns `anyhow::Result<Config>`.
- Sensitive fields: exclude from `Debug` or implement custom redaction.
- Defaults via `#[serde(default = "...")]` — explicit and auditable.

## Telemetry

From the [telemetry](../telemetry.md) rules:

```rust
pub fn init() -> (ReloadHandle, impl Drop) {
    // Build minimal subscriber, set as global default
    // Return reload handle + flush-on-drop guard
}

pub fn reconfigure(handle: &ReloadHandle, config: &TelemetryConfig) {
    // Apply full configuration to the running subscriber
}
```

- Log level controlled via `RUST_LOG` environment variable or config.
- Library `#[instrument]` spans become observable through
  the binary's tracing subscriber.

## Error Handling

From the [error handling](../error-handling.md) rules:

- `anyhow::Result` exclusively. No `Error` enums in binary crates.
- `thiserror` errors from libraries propagate through `?`.
- Business context via `.context()` at each significant operation.
- `.unwrap()` and `.expect()` are forbidden.

## Testing

From the [testing](../testing.md) rules:

```rust
#[tokio::test]
async fn config_load_failure_prevents_startup() {
    let bad_config = Config { /* invalid */ };
    let result = run(bad_config).await;
    assert!(result.is_err());
}
```

```rust
#[tokio::test]
async fn full_startup_and_shutdown() {
    let config = test_config();
    let handle = tokio::spawn(run(config));
    // Send shutdown signal, verify clean exit
}
```

Use `testcontainers` for real database dependencies in integration tests.
