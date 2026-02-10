# Panic Policy

## Universal Rule

Panic-inducing code must not be written intentionally.
The following are forbidden in all crates (library and binary):

- `.unwrap()`
- `.expect()`
- `panic!()`
- `unreachable!()` without a proven invariant
- `todo!()` in published code

All fallible operations use `Result` and propagate errors through `?`.

## Panic as Safety Net

Panic exists as an invisible safety net for programming bugs.
If a logic error creates a state that was not anticipated,
Rust's panic mechanism prevents undefined behavior.

This is not a permission to write panic code.
It is an acknowledgment that panics may occur due to bugs,
and when they do, the program terminates safely rather than
continuing in a corrupted state.

## Binary Crate — Startup Boundary

Binary crates have an additional distinction based on lifecycle phase:

- **Before `run()` starts successfully** (initialization phase):
  errors should be returned as `Result::Err` with specific context,
  feedback, and clean self-termination.
  If an unrecoverable programming bug causes a panic during initialization,
  the process terminates immediately. This is acceptable as a last resort.
- **After `run()` starts successfully** (operational phase):
  panic is categorically forbidden.
  All errors propagate through `Result` and the graceful shutdown mechanism
  (see [shutdown](../../bin/shutdown.md)).

In well-designed snowball binaries, panics during initialization
should be extremely rare or nonexistent.
