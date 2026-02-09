# Stateless Sync Library

The most fundamental library type. Pure functions: same input always produces same output.

## Definition (all conditions must hold)

- All public functions are pure.
- No mutable state, no `static mut`, `lazy_static`, or `OnceLock`.
- No I/O (no file access, no network, no environment variables).
- No background threads, no `spawn`.
- Synchronous return, no `Future`.

## File Structure

```
src/
  lib.rs          Module declarations and explicit re-exports only.
  types.rs        Input, output, and error type definitions.
  traits.rs       Trait definitions (if this crate defines a capability).
  core.rs         Core logic. The only file permitted to contain business code.
tests/
  integration.rs
```

`lib.rs` uses explicit re-exports, not globs:

```rust
mod types;
mod traits;
mod core;

pub use types::{Input, Output, MyError};
pub use traits::MyTrait;
pub use core::MyImpl;
```

## Core Logic Constraints (core.rs)

- Stays near or under 300 lines (excluding comments and blank lines).
- No `unwrap()`, `expect()`, `panic!()`, `todo!()`, `unimplemented!()`.
- No `unsafe` unless the crate's core purpose is wrapping unsafe operations.
  If unsafe is present, safety invariants must be documented.
- No logging, no printing.
- No environment variable reads or global configuration access.

## Cargo.toml Constraints

- Explicit `edition` and `rust-version`.
- Minimize dependencies.
- `tokio`, `async-std`, `log`, `tracing` must not appear in `[dependencies]`.

## Checklist

1. `lib.rs` contains only `mod` and `pub use`.
2. All public functions produce identical output for identical input.
3. Error type is a `#[non_exhaustive]` enum with `thiserror::Error`.
4. No `unwrap`, `expect`, `panic`, `todo`.
5. No I/O, no global state, no logging.
6. Core logic stays near or under 300 lines.
7. Every public function has a happy-path test.
8. Every Error variant has an error-path test.
9. All public items have doc comments with examples.
10. No async runtime or logging framework in dependencies.
