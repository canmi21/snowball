# Unsafe Code

## Default Stance

Unsafe code is forbidden unless one of the following categories applies.

## Categories

### 1. Safe-by-Default Crate

The vast majority of snowball crates fall here.

- `#[deny(unsafe_code)]` is set in `lib.rs`.
- Unsafe is permitted only when it is the crate's **core purpose**
  (e.g., a custom allocator, a lock-free data structure).
- When permitted, the crate's top-level doc comment must state
  why unsafe is necessary.

### 2. FFI Binding Crate

Crates that bridge Rust with C libraries, system APIs,
or hardware registers.

- Unsafe is the crate's reason for existing.
- The crate must be a **thin wrapper**: the unsafe layer is as small as possible,
  and all public API surfaces are safe.
- Callers of the crate must never need to write unsafe code themselves.
- Applicable to embedded (hardware register access), desktop (system API bindings),
  and any other domain requiring foreign function calls.

### 3. Performance-Critical Path

Unsafe used to achieve performance that safe Rust cannot match.

- A safe implementation must exist as the default.
- The unsafe alternative must be accompanied by benchmarks
  demonstrating a measurable improvement.
- If the safe version is fast enough, the unsafe version is not justified.

## Shared Rules (All Categories)

### SAFETY Annotation

Every `unsafe` block must be preceded by a `// SAFETY:` comment
(required by the `undocumented_unsafe_blocks` clippy lint).

The comment is a declarative sentence explaining which invariants
are upheld and how they are guaranteed at this specific call site.
See [code-comments](../../lib/practices/documentation/code-comments.md).

### Safe API Boundary

Unsafe internals must not leak to callers.
The public API of any crate containing unsafe code must be entirely safe.
A caller should never need to reason about memory safety
when using the crate.

### Testing

Crates with unsafe code require additional verification:

- Run tests under Miri (`cargo +nightly miri test`) when possible.
- Use address and thread sanitizers in CI for FFI-heavy crates.
- Unsafe-related edge cases feed into Layer 1 and Layer 2 tests
  (see [testing](../../lib/practices/testing.md)).
