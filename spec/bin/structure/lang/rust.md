# Binary Structure — Rust

Rust-specific implementation details for the binary
[structure](../) specifications.

## File Names

From the [layout](../layout.md) minimum set:

| Category             | Always present                           | Present when needed |
| -------------------- | ---------------------------------------- | ------------------- |
| CLI tool             | main.rs, run.rs, config.rs               | telemetry.rs        |
| Long-running service | main.rs, run.rs, config.rs, telemetry.rs | —                   |

When a file expands into a directory: `run.rs` → `run/mod.rs` + submodules.

## Entry Point — CLI Tool

```rust
fn main() {
    let config = config::load();
    if let Err(e) = run::run(config) {
        // output full error chain
        std::process::exit(1);
    }
}
```

## Entry Point — Long-Running Service

```rust
#[tokio::main]
async fn main() {
    let (reload_handle, _guard) = telemetry::init();
    let config = config::load();
    telemetry::reconfigure(&reload_handle, &config.telemetry);
    if let Err(e) = run::run(config).await {
        // output full error chain
        std::process::exit(1);
    }
}
```

## Orchestration Function

```rust
pub async fn run(config: Config) -> anyhow::Result<()> {
    // assembly + orchestration
}
```

`run()` returns `anyhow::Result<()>`.
For CLI tools, `run()` may be synchronous (not async).

## Async Runtime

Most long-running services use `tokio` as the async runtime.
This is a practical default, not a mandate.
