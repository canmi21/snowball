# Binary Crate Layout

## Two Categories

Binary crates fall into two categories based on lifecycle:

- **CLI tool**: executes a task and exits.
- **Long-running service**: runs continuously until a shutdown signal is received.

The file layout and main.rs flow differ between the two.

## Minimum Set

| Category             | Always present                     | Present when needed |
| -------------------- | ---------------------------------- | ------------------- |
| CLI tool             | entry point, orchestration, config | telemetry           |
| Long-running service | entry point, orchestration, config, telemetry | —        |

For language-specific file names, see [lang/](lang/).

## Scaling

When orchestration complexity grows, single files expand into directories
with a module entry point plus subsystem modules.

Nesting depth must stay under 4 levels.
Each file within a directory should be focused and small,
but there is no hard line count — clarity is the goal.

## Naming

Source code files follow language convention
(see [file naming](../../foundation/naming/file-structure.md)).
Directory names use lowercase letters and hyphens.

Use directory hierarchy to avoid redundant prefixes:
`system/monitor`, not `system/system_monitor`.
