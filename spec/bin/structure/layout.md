# Binary Crate Layout

## Two Categories

Binary crates fall into two categories based on lifecycle:

- **CLI tool**: executes a task and exits.
- **Long-running service**: runs continuously until a shutdown signal is received.

The file layout and main.rs flow differ between the two.

## Minimum Set

| Category | Always present | Present when needed |
|----------|---------------|-------------------|
| CLI tool | main.rs, run.rs, config.rs | telemetry.rs |
| Long-running service | main.rs, run.rs, config.rs, telemetry.rs | — |

## Scaling

When orchestration complexity grows, single files expand into directories:

- `run.rs` → `run/` (mod.rs + subsystem modules)
- `config.rs` → `config/` (mod.rs + subsystem configs)
- Same for `telemetry.rs` and any other module.

Nesting depth must stay under 4 levels.
Each file within a directory should be focused and small,
but there is no hard line count — clarity is the goal.

## Naming

- File and directory names use lowercase letters and hyphens only:
  `shutdown-handler.rs`, `health-check/`.
- Use directory hierarchy to avoid redundant prefixes:
  `system/monitor.rs`, not `system/system-monitor.rs`.
