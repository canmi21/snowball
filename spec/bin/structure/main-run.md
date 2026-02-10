# Entry Point and Orchestration

## Entry Point

The entry point is kept as short as possible.
The steps below are the recommended structure, not a rigid template.
Specifics may vary, but the spirit holds:
the entry point is thin, the orchestration function does the real work.

For language-specific entry point examples, see [lang/](lang/).

### CLI Tool (2–3 steps)

1. Load configuration.
2. Call the orchestration function. On failure, output the error chain and exit.

Telemetry initialization is optional for CLI tools. When present, it becomes 3 steps.

### Long-Running Service (4 steps)

1. Initialize telemetry with minimal defaults.
2. Load configuration.
3. Reconfigure telemetry with loaded settings.
4. Call the orchestration function. On failure, output the error chain and exit.

The entry point does not construct services, handle signals,
or contain business logic.

## Orchestration Function

The single orchestration site in the binary:

- Receives configuration as its only required parameter.
- Constructs all dependencies in order (see [assembly](../assembly.md)).
- Starts services, installs the shutdown mechanism
  (see [shutdown](../shutdown.md), long-running service only).
- Returns a result type appropriate for the language's error handling.

The orchestration function is always the entry point for logic,
even when the module expands into a directory.

For CLI tools, the orchestration function may be synchronous (not async).

All testable logic lives in the orchestration function.
Integration tests call it directly, not the binary process
(see [testing](../testing.md)).

## Async Runtime

The choice of async runtime is a binary-level decision
and does not affect library crate design.

Library crates remain runtime-agnostic
(see [stateful-async](../../lib/patterns/stateful-async.md) runtime dependency tiers).

## Dependency Path

- A binary crate preferably depends on convergence crates,
  not on leaf or composition crates directly.
- Convergence crates re-export all types the binary needs.
- Direct dependency on lower-level crates is permitted
  when a convergence layer does not yet exist or would be unnecessary overhead.
