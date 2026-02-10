# Stateless Async Library

Pure function combined with I/O. Returns a Future but leaves no residual state.
Builds on [stateless-sync](stateless-sync.md); only differences are listed here.

## Definition (on top of sync conditions)

- Returns a `Future`, but no state persists after the future completes.
- I/O (network, file) is permitted. This is the reason async exists.
- If an operation does not perform I/O or waiting, it must not be marked `async`.
  Do not make pure computation async for stylistic uniformity.

## Core Logic Differences

- No direct runtime API calls (`tokio::spawn`, `tokio::time::sleep`, `tokio::fs::read`).
- I/O capabilities are injected through traits, not called directly.
- No internal concurrency control (`join!`, `select!`, `Semaphore`).
- No `block_on`.

## Cargo.toml Differences

- Async runtime appears only in `dev-dependencies` (for testing).
- `futures-core` is the only permitted async abstraction dependency (for `Stream`).

## Sync/Async Coexistence

When both sync and async versions of a capability exist, split into two crates:

```
my-parser/             Pure sync parsing logic.
my-parser-async/       Async I/O shell; internally calls my-parser for actual parsing.
```

Do not use feature flags to switch between sync and async within a single crate.

## Additional Checklist (extends SS-1 to SS-10)

- SA-1. Traits and returned futures are bounded `Send`.
- SA-2. No concrete runtime in `[dependencies]`. Runtime only in `[dev-dependencies]`.
- SA-3. No direct runtime API calls.
- SA-4. All I/O capabilities injected through traits.
- SA-5. Error type covers `Timeout` and `Cancelled` categories.
- SA-6. Tests use mock I/O.
