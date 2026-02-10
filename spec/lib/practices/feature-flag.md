# Feature Flags

## By Crate Role

### Leaf Crate — Minimal Features Only

Leaf crates may only use feature flags for:

1. **Capability tiers.**
   Higher tiers expose additional APIs; they never change
   the behavior of APIs available at lower tiers.
   See [no-std](no-std.md) for the standard tier model.

2. **Optional instrumentation.**
   Adds span annotations for observability. See [observability](observability.md).

3. **Optional derived capabilities** (e.g., serialization support).
   Adds interface implementations to existing types.
   Never changes the behavior of existing APIs.

Leaf crates do **not** have a `full` feature. There is nothing to "fully enable" —
each feature is a capability addition, and the combination is determined
by the consumer.

For language-specific feature flag syntax, see [lang/](lang/).

### Composition Crate — Pass-Through Features

Composition crates may use feature flags to:

1. **Pass through features from lower crates.**
   When a dependency exposes a feature (e.g., `tracing`),
   the composition crate re-exposes it under the same name.

2. **Optional lower-crate dependencies.**
   When a lower crate is not always needed,
   gate it behind a feature flag.

Composition crates do not introduce new capability dimensions.
Feature selection belongs in convergence crates.

### Convergence Crate — Selection Features

Convergence crates may use feature flags to select between implementations
within a single dimension.

Rules:

- Each feature flag represents a choice within **one dimension**.
- A single convergence crate handles only one dimension of selection.
- No more than three or four options per dimension.

### Mutual Exclusivity

Features within a dimension are **multi-select by default**.
Enabling both `toml` and `json` makes both implementations available.

Features are **mutually exclusive** only when the implementations are functionally
identical and cannot coexist (e.g., two alternative crypto backends).
In this case, enforce the constraint with a compile-time error.

A `full` feature in convergence crates is acceptable — it activates all
non-mutually-exclusive selections.

## Forbidden Uses

- Feature flags that change the behavior of existing APIs in leaf crates.
- Behavioral branching (conditional compilation that changes existing behavior)
  in leaf or composition crates.
- Multiple unrelated dimensions of selection in a single crate.

## Principle

Feature flags control **capability presence**, never **behavioral variation**.
Enabling a feature adds new APIs or new trait implementations.
It never alters the behavior of APIs that exist without the feature.
