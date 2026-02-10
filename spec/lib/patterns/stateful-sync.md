# Stateful Sync Library

Holds internal mutable state. Output may depend on call history.
Builds on [stateless-sync](stateless-sync.md); only differences are listed here.

## Definition (on top of sync conditions)

- Internal mutable state is permitted.
- Output may depend on call history.
- Holding immutable data (e.g., parsed configuration) does not count as stateful.
  Stateful means internal state changes with method calls.

## File Structure Difference

Add `state.rs` for the state container definition and state transition logic.
State definition is separated from business logic.

## State Design (Typestate Pattern)

Typestate is recommended for lifecycle management.
It is mandatory for irreversible operations.

- Each lifecycle phase is a distinct type.
- Phase transitions consume `self` (`fn transition(self) -> NextPhase`).
- Irreversible operations (e.g., `close`) must consume `self`.
  The compiler prevents subsequent use.
- Do not use an internal enum for states that can be encoded in the type system.

When the state machine is trivial (e.g., two states, no irreversible transitions),
a runtime enum is acceptable.

## Initialization

- Construct through the builder pattern or an explicit `new(config)`.
- All validation completes inside `build()`, which returns `Result`.
- Builder methods take `self -> Self` (move-based), not `&mut self`.
- No "construct then initialize" pattern. An object is usable immediately after construction.

## Core Logic Differences

- If `Drop` is implemented, it must not panic and must not perform blocking I/O.

## Additional Checklist (extends SS-1 to SS-10)

- SFS-1. Lifecycle phases encoded as distinct types where applicable.
- SFS-2. Irreversible operations consume `self`.
- SFS-3. `&self` and `&mut self` methods belong to separate traits.
- SFS-4. Construction uses builder or explicit `new`. No post-construction initialization.
- SFS-5. Construction errors and runtime errors are independent `Error` types.
- SFS-6. Failed operations do not corrupt existing state (transactional semantics).
- SFS-7. No interior mutability except for pure cache optimization.
- SFS-8. `Drop` implementation does not panic or block.
