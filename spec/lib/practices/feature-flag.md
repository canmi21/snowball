# Feature Flags

## By Crate Role

### Leaf Crate — Minimal Features Only

Leaf crates may only use feature flags for:

1. **`std` / `alloc` capability tiers.**
   `default = ["std"]`, `std = ["alloc"]`, `alloc = []`.
   There is no `no_std` feature — `no_std` is the implicit result
   of `default-features = false`. See [no-std](no-std.md).
   Enabling a tier exposes additional APIs; it never changes
   the behavior of APIs available at lower tiers.

2. **Optional `tracing` instrumentation.**
   Adds `#[instrument]` span annotations. See [observability](observability.md).

3. **Optional derive support** (e.g., `serde`).
   Adds trait implementations to existing types.
   Never changes the behavior of existing APIs.

Leaf crates do **not** have a `full` feature. There is nothing to "fully enable" —
each feature is a capability addition, and the combination is determined
by the consumer.

### Convergence Crate — Selection Features

Convergence crates may use feature flags to select between implementations
within a single dimension:

```toml
[features]
default = ["toml"]
toml = ["dep:config-parse-toml"]
json = ["dep:config-parse-json"]
```

Rules:

- Each feature flag represents a choice within **one dimension**.
- A single convergence crate handles only one dimension of selection.
- No more than three or four options per dimension.

### Mutual Exclusivity

Features within a dimension are **multi-select by default**.
Enabling both `toml` and `json` makes both implementations available.

Features are **mutually exclusive** only when the implementations are functionally
identical and cannot coexist (e.g., `ring` vs `aws-lc-rs` as a crypto backend).
In this case, use `compile_error!` to enforce the constraint.

A `full` feature in convergence crates is acceptable — it activates all
non-mutually-exclusive selections.

## Forbidden Uses

- Feature flags that change the behavior of existing APIs in leaf crates.
- Behavioral branching (`if cfg!(feature = "x") { ... } else { ... }`)
  in leaf or composition crates.
- Multiple unrelated dimensions of selection in a single crate.

## Principle

Feature flags control **capability presence**, never **behavioral variation**.
Enabling a feature adds new APIs or new trait implementations.
It never alters the behavior of APIs that exist without the feature.
