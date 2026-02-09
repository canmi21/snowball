# Binary Crate Structure

## Two Categories

Binary crates fall into two categories based on lifecycle:

- **CLI tool**: executes a task and exits.
- **Long-running service**: runs continuously until a shutdown signal is received.

The file layout and main.rs flow differ between the two.

## File Layout

### Minimum Set

| Category | Always present | Present when needed |
|----------|---------------|-------------------|
| CLI tool | main.rs, run.rs, config.rs | telemetry.rs |
| Long-running service | main.rs, run.rs, config.rs, telemetry.rs | — |

### Scaling

When orchestration complexity grows, single files expand into directories:

- `run.rs` → `run/` (mod.rs + subsystem modules)
- `config.rs` → `config/` (mod.rs + subsystem configs)
- Same for `telemetry.rs` and any other module.

Nesting depth must stay under 4 levels.
Each file within a directory should be focused and small,
but there is no hard line count — clarity is the goal.

### Naming

- File and directory names use lowercase letters and hyphens only: `shutdown-handler.rs`, `health-check/`.
- Use directory hierarchy to avoid redundant prefixes:
  `system/monitor.rs`, not `system/system-monitor.rs`.

## main.rs

The entry point. Kept as short as possible.
The steps below are the recommended structure, not a rigid template.
Specifics may vary, but the spirit holds: main.rs is thin, run() is the orchestration point.

### CLI Tool (2–3 steps)

```rust
fn main() {
    let config = config::load();
    if let Err(e) = run::run(config) {
        // output full error chain
        std::process::exit(1);
    }
}
```

Telemetry initialization is optional for CLI tools.
When present, it becomes 3 steps.

### Long-Running Service (4 steps)

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

main.rs does not construct services, handle signals, or contain business logic.

## run.rs

The single orchestration site in the binary:

- Receives configuration as its only required parameter.
- Constructs all dependencies in order (see [assembly](assembly.md)).
- Starts services, installs the shutdown mechanism
  (see [shutdown](shutdown.md), long-running service only).
- Returns `anyhow::Result<()>`.

The `run()` function is always the entry point, even when the module
expands into a directory. In that case, `run/mod.rs` contains `run()`
and delegates to submodules.

For CLI tools, `run()` may be synchronous (not async).

All testable logic lives in `run()`. Integration tests call `run()` directly,
not the binary process (see [testing](testing.md)).

## Async Runtime

Most long-running services use tokio as the async runtime.
This is a practical default, not a mandate — the choice of runtime
is a binary-level decision and does not affect library crate design.

Library crates in the snowball monorepo remain runtime-agnostic
(see [stateful-async](../lib/patterns/stateful-async.md) runtime dependency tiers).

## Dependency Path

- A binary crate preferably depends on convergence crates,
  not on leaf or composition crates directly.
- Convergence crates re-export all types the binary needs.
- Direct dependency on lower-level crates is permitted
  when a convergence layer does not yet exist or would be unnecessary overhead.
