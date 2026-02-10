# Stateful Async Library

State management combined with async execution and concurrent access.
The most complex library type.
Builds on all three preceding patterns; only differences are listed here.

## Definition

- Faces three simultaneous dimensions: state management, async execution, concurrent access.
- If all operations are CPU-bound with no waiting, use [stateful-sync](stateful-sync.md) instead.
  This pattern applies only when state operations genuinely require I/O or event waiting.

## File Structure Difference

Add `handle.rs` for the running instance's control interface.

## Concurrency Strategy (choose one)

**Route A (recommended): std synchronization locks with short critical sections.**

- Critical section contains only in-memory reads and writes. No `.await` inside.
- Does not bind to any async runtime.

**Route B: Abstract lock mechanism through a trait.**

- Use only when the critical section genuinely requires `.await`.

The chosen route must be documented in the `state.rs` module-level doc comment.
Never hold a synchronization lock across an `.await` point (deadlock risk).

## Handle Design

- Handle must be `Clone + Send + Sync`.
- All methods use `&self`. No `&mut self` in concurrent contexts.
- Lock acquisition and async operations must be separated:
  acquire lock, read/write data, release lock, then perform async work.
- `shutdown` consumes `self` via a shutdown signal mechanism.

## Spawn and Concurrency Rules

### Trait-Level Crate (Runtime-Agnostic)

- No direct runtime dependency.
- No `spawn`, no runtime-specific channels or timers.
- Expose capabilities as async functions. The caller decides where to run them.

### Runtime-Specific Implementation Crate (e.g., xxx-tokio)

This crate has committed to a specific runtime and may use its capabilities:

- Runtime timers (`tokio::time::sleep`), channels (`tokio::sync::mpsc`),
  and synchronization primitives are permitted.
- **Bounded spawn** is permitted. A spawn is bounded when:
  (a) it is created within an operation's scope,
  (b) it is joined or awaited before the operation returns, and
  (c) the caller cannot observe the spawned tasks — they are an implementation detail.
  Example: spawning N health checks in parallel and collecting results via `join_all`.
- **Unbounded spawn** is forbidden. A spawn is unbounded when:
  (a) the spawned task outlives the calling function, or
  (b) the task runs indefinitely (background loops, event listeners).
  Expose such work as an `async fn` and let the caller spawn it.

```rust
// Correct: expose background work as a future.
pub async fn cleanup_loop(&self) -> Result<!, Error> {
    loop {
        tokio::time::sleep(Duration::from_secs(60)).await;
        self.cleanup().await?;
    }
}
// Caller decides: tokio::spawn(service.cleanup_loop());
```

### Application-Layer Orchestration (app repo)

- Unbounded spawn is permitted. This layer makes the final scheduling decisions.

## Runtime Dependency Tiers

| Crate level                 | Rule                                                             |
| --------------------------- | ---------------------------------------------------------------- |
| Leaf / trait crate          | Strictly runtime-agnostic.                                       |
| Runtime-specific impl crate | Committed to one runtime. Uses its features. No unbounded spawn. |
| Convergence crate           | Selects runtime impl via features. Zero logic.                   |
| App orchestration / bin     | Full runtime access. Unbounded spawn permitted.                  |

## Additional Checklist

Inherits SS-1 to SS-10, SA-1 to SA-6,
and SFS-2, SFS-4 to SFS-6, SFS-8.

Excluded from stateful-sync:

- SFS-1 (lifecycle phases): typestate is optional in async contexts
  where handle-based access dominates.
- SFS-3 (&self/&mut self split): replaced by SFA-4 (all `&self`).
- SFS-7 (no interior mutability except cache): does **not** apply.
  Interior mutability is the standard mechanism for stateful async crates.

Items specific to stateful async:

- SFA-1. Concurrency strategy documented in `state.rs` module docs.
- SFA-2. No lock held across `.await` points.
- SFA-3. Handle is `Clone + Send + Sync`.
- SFA-4. All trait methods use `&self`. No `&mut self`.
- SFA-5. No unbounded spawn in library crates. Bounded spawn (structured concurrency) is permitted.
- SFA-6. `shutdown` semantics are explicit. Post-shutdown operations return `ShuttingDown` error.
- SFA-7. Concurrent read/write tests present.
- SFA-8. Graceful shutdown and post-shutdown behavior tests present.
- SFA-9. Leaf crates do not bind to a runtime. Runtime-specific crates document the binding.
