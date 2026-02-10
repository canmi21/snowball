# Library Patterns — Rust

Rust-specific implementation details for the library
[patterns](../).

## File Layout

```
my-crate/
├── Cargo.toml
├── src/
│   ├── lib.rs          # mod + pub use only
│   ├── types.rs        # input, output, error types
│   ├── traits.rs       # trait definitions (if any)
│   ├── core.rs         # business logic
│   ├── state.rs        # stateful-sync: state container + transitions
│   └── handle.rs       # stateful-async: running instance control
└── tests/
    └── integration.rs
```

Entry point (`lib.rs`):

```rust
mod types;
mod core;

pub use types::{Input, Output, Error};
pub use core::transform;
```

## Typestate Pattern

From the [stateful-sync](../stateful-sync.md) state design.
Irreversible operations consume `self`, preventing reuse at compile time:

```rust
pub struct Builder { /* ... */ }
pub struct Ready { /* ... */ }

impl Builder {
    pub fn build(self) -> Result<Ready, BuildError> { /* ... */ }
}
```

## Cleanup

Implement `Drop` for resource cleanup.
`Drop::drop` must not panic and must not perform blocking I/O.

## Handle Implementation

From the [stateful-async](../stateful-async.md) handle design:

```rust
#[derive(Clone)]
pub struct Handle {
    inner: Arc<Inner>,
}
```

Handle is `Clone + Send + Sync`. All methods take `&self`.

## Lock Strategy

Prefer `std::sync::Mutex` for short critical sections
(copy data out, release lock, then perform async work).

Use `tokio::sync::Mutex` only when holding a lock across
a suspension point is unavoidable — the spec discourages this.

Correct pattern — release lock before `.await`:

```rust
let data = {
    let guard = self.inner.state.lock().map_err(|_| Error::Poisoned)?;
    guard.clone()
};
self.do_async_work(&data).await;
```

## Spawn Rules

From the [stateful-async](../stateful-async.md) concurrency rules:

- **Bounded**: `tokio::spawn` with `JoinHandle` joined before return.
- **Unbounded**: `tokio::spawn` without join — forbidden in library crates.

## Runtime Dependencies

| Crate level           | `tokio` dependency                    |
| --------------------- | ------------------------------------- |
| Leaf / interface      | None. Runtime-agnostic.               |
| Runtime-specific impl | `tokio` in `[dependencies]`.          |
| Convergence           | `tokio` gated behind a feature flag.  |
| Stateless async tests | `tokio` in `[dev-dependencies]` only. |

Interior mutability rules: see [contract/lang/rust](../../contract/lang/rust.md).
