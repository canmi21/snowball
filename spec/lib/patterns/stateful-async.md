# Stateful Async Library

State management combined with async execution and concurrent access.
The most complex library type.
Builds on all three preceding patterns; only differences are listed here.

## Definition

- Faces three simultaneous dimensions: state management, async execution, concurrent access.
- If all operations are CPU-bound with no waiting, use [stateful-sync](stateful-sync.md) instead.
  This pattern applies only when state operations genuinely require I/O or event waiting.

## File Structure Difference

Add a handle file for the running instance's control interface.

## Concurrency Strategy

Choose between synchronization locks with short critical sections
(recommended) or an abstract lock mechanism through an interface.

The chosen route must be documented.
Never hold a synchronization lock across an async suspension point.

## Handle Design

- Handle must be cloneable and thread-safe.
- All methods use shared (read-only) references.
- Lock acquisition and async operations must be separated:
  acquire lock, read/write data, release lock, then perform async work.
- Shutdown consumes the handle via a signal mechanism.

## Spawn and Concurrency Rules

### Interface-Level Package (Runtime-Agnostic)

- No direct runtime dependency.
- No spawn, no runtime-specific channels or timers.
- Expose capabilities as async functions. The caller decides where to run them.

### Runtime-Specific Implementation Package

- **Bounded spawn** is permitted: created within scope, joined before return,
  invisible to callers.
- **Unbounded spawn** is forbidden in library packages.
  Expose long-running work as an async function and let the caller spawn it.

### Application-Layer Orchestration

- Unbounded spawn is permitted. This layer makes the final scheduling decisions.

## Runtime Dependency Tiers

| Package level              | Rule                                            |
| -------------------------- | ----------------------------------------------- |
| Leaf / interface package   | Strictly runtime-agnostic.                      |
| Runtime-specific impl      | Committed to one runtime. No unbounded spawn.   |
| Convergence package        | Selects runtime impl via features. Zero logic.  |
| App orchestration / binary | Full runtime access. Unbounded spawn permitted. |

## Additional Checklist

Inherits SS-1 to SS-10, SA-1 to SA-6,
and SFS-2, SFS-4 to SFS-6, SFS-8.

Excluded from stateful-sync:

- SFS-1 (lifecycle phases): optional in async contexts
  where handle-based access dominates.
- SFS-3 (read/mutate split): replaced by SFA-4 (all shared references).
- SFS-7 (no interior mutability except cache): does **not** apply.
  Interior mutability is the standard mechanism for stateful async packages.

Items specific to stateful async:

- SFA-1. Concurrency strategy documented in state module.
- SFA-2. No lock held across async suspension points.
- SFA-3. Handle is cloneable and thread-safe.
- SFA-4. All interface methods use shared references.
- SFA-5. No unbounded spawn in library packages. Bounded spawn permitted.
- SFA-6. Shutdown semantics are explicit. Post-shutdown operations return error.
- SFA-7. Concurrent read/write tests present.
- SFA-8. Graceful shutdown and post-shutdown behavior tests present.
- SFA-9. Leaf packages do not bind to a runtime.
