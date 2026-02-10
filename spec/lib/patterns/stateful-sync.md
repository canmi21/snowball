# Stateful Sync Library

Holds internal mutable state. Output may depend on call history.
Builds on [stateless-sync](stateless-sync.md); only differences are listed here.

## Definition (on top of sync conditions)

- Internal mutable state is permitted.
- Output may depend on call history.
- Holding immutable data (e.g., parsed configuration) does not count as stateful.
  Stateful means internal state changes with method calls.

## File Structure Difference

Add a state file for the state container definition and state transition logic.
State definition is separated from business logic.

## State Design

Encode lifecycle phases in the type system where the language supports it.
Irreversible operations should consume the object,
preventing subsequent use at compile time.

When the state machine is trivial (e.g., two states,
no irreversible transitions), a runtime enum is acceptable.

For language-specific typestate implementation, see [lang/](lang/).

## Initialization

- Construct through the builder pattern or an explicit constructor.
- All validation completes inside the build step, which returns a result.
- No "construct then initialize" pattern.
  An object is usable immediately after construction.

## Core Logic Differences

- Cleanup/destructor must not panic and must not perform blocking I/O.

## Additional Checklist (extends SS-1 to SS-10)

- SFS-1. Lifecycle phases encoded as distinct types where applicable.
- SFS-2. Irreversible operations consume the object.
- SFS-3. Read-only and mutating methods belong to separate interfaces.
- SFS-4. Construction uses builder or explicit constructor. No post-construction init.
- SFS-5. Construction errors and runtime errors are independent error types.
- SFS-6. Failed operations do not corrupt existing state (transactional semantics).
- SFS-7. No interior mutability except for pure cache optimization.
- SFS-8. Cleanup/destructor does not panic or block.
