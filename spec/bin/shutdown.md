# Graceful Shutdown

Applies to long-running services. CLI tools do not require shutdown handling.

## Mechanism

The binary requires a signal-based shutdown mechanism
that propagates a cancellation signal from the top level downward.

The concrete implementation (e.g., `CancellationToken`, channel, flag)
is not mandated by this specification.
The snowball ecosystem will provide a shutdown crate early on.

## Flow

1. Register listeners for OS termination signals (e.g., `SIGINT`, `SIGTERM`) in `run()`.
2. On signal, propagate cancellation to all running tasks.
3. All subtasks observe the cancellation and clean up.
4. A timeout enforces an upper bound on shutdown duration.

## Rules

- The cancellation signal originates in `run()` and propagates downward.
  Subtasks do not create their own top-level cancellation sources.
- A shutdown timeout is mandatory. Waiting indefinitely for subtasks is forbidden.
- When the timeout expires: record which tasks did not complete, then exit.
- On next startup, the binary may read the previous abnormal termination record
  and produce a warning. The form of this feedback (log, internal record, alert)
  is the binary author's decision.
- Shutdown signal handling lives exclusively in `run()`.
  It is not distributed across submodules.

## Panic Policy

- **Before `run()` starts successfully** (initialization phase):
  the primary path returns `Result::Err` with a specific error, feedback,
  and clean self-termination.
  Panic is permitted as a last-resort safety net for programming bugs,
  but should be extremely rare in well-designed snowball binaries.
- **After `run()` starts successfully** (operational phase):
  panic is forbidden. All errors propagate through `Result` and the
  graceful shutdown mechanism.

## Relationship to Library Crates

- Stateful async library crates expose their own shutdown interface
  (see [stateful-async](../lib/patterns/stateful-async.md) item 24).
- The binary calls each library's shutdown method
  and manages the overall timeout and exit strategy.
- Library crates do not know the binary's cancellation mechanism.
  The binary bridges its cancellation signal to each library's shutdown interface.
