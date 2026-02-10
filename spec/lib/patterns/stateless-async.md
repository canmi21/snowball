# Stateless Async Library

Pure function combined with I/O. Returns a Future but leaves no residual state.
Builds on [stateless-sync](stateless-sync.md); only differences are listed here.

## Definition (on top of sync conditions)

- Returns an async result, but no state persists after the operation completes.
- I/O (network, file) is permitted. This is the reason async exists.
- If an operation does not perform I/O or waiting, it must not be async.
  Do not make pure computation async for stylistic uniformity.

## Core Logic Differences

- No direct runtime API calls.
- I/O capabilities are injected through interfaces, not called directly.
- No internal concurrency control (parallel joins, selects, semaphores).
- No blocking within async contexts.

## Sync/Async Coexistence

When both sync and async versions of a capability exist,
split into two packages:

- Sync package: pure synchronous logic.
- Async package: async I/O shell, internally calls the sync package.

Do not use feature flags to switch between sync and async
within a single package.

## Additional Checklist (extends SS-1 to SS-10)

- SA-1. Interfaces and returned async values are thread-safe.
- SA-2. No concrete runtime in production dependencies.
- SA-3. No direct runtime API calls.
- SA-4. All I/O capabilities injected through interfaces.
- SA-5. Error type covers timeout and cancellation categories.
- SA-6. Tests use mock I/O.
