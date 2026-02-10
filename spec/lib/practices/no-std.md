# no_std Support

## Decision Criteria

| Condition | Conclusion |
|-----------|-----------|
| Trait method signatures contain no std-only types (File, Path, TcpStream, Mutex) | Can be `no_std` |
| Implementation uses heap allocation (Vec, String, Box) | Requires `alloc`, still `no_std` compatible |
| Implementation interacts with the operating system | Requires `std` |

## Three Capability Tiers

| Tier | Contents | Environment Requirement |
|------|----------|----------------------|
| `core` | Option, Result, fundamental traits | All environments |
| `alloc` | Vec, String, Box, Arc | Requires an allocator, no OS needed |
| `std` | File, network, threads | Requires an OS |

## Feature Gate Pattern

```toml
[features]
default = ["std"]
std = ["alloc"]
alloc = []
```

Enabling `alloc` does not change the behavior of core APIs —
it exposes additional APIs that require heap allocation.

Enabling `std` does not change the behavior of core or alloc APIs —
it exposes additional APIs that require the operating system.

This is capability presence, not behavioral variation
(see [feature-flag](feature-flag.md) for the full feature flag rules).

## lib.rs for no_std Crates

A `no_std` crate's `lib.rs` may contain crate-level attributes
and conditional compilation declarations:

```rust
#![no_std]

#[cfg(feature = "alloc")]
extern crate alloc;

mod types;
mod transform;

pub use types::{MyInput, MyOutput, MyError};
pub use transform::my_transform;
```

This is the only exception to the rule that `lib.rs` contains
only module declarations and re-exports.
No business logic is permitted in `lib.rs` even for `no_std` crates.
