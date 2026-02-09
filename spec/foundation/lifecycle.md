# Crate Lifecycle

## Three Phases

### Phase 1 — Exploration (0.x)

- Trait boundaries are not yet settled; frequent changes are expected.
- Version number stays at `0.x`.
- Breaking changes are permitted between minor versions.
- Layer 1 + Layer 2 tests (happy path + error path) are still required from day one.

### Phase 2 — Stability (1.0)

- The public interface has been validated through actual usage.
- Version number advances to `1.0`.
- From this point: **additive changes only**.

Post-1.0 change rules:

| Change | Allowed | Version bump |
|--------|---------|-------------|
| Bug fix (no API change) | Yes | Patch (1.0.x) |
| New default method on existing trait | Yes | Minor (1.x.0) |
| New public type or function | Yes | Minor (1.x.0) |
| Change method signature | **No** — write a new crate | — |
| Remove public item | **No** — write a new crate | — |

**If a change would break any existing dependent code, it is forbidden.**
Create a new crate instead.

Major version bumps (2.0) should be an extremely rare event in this ecosystem.

### Phase 3 — Convergence

- The crate is repeatedly used alongside specific other crates.
- **Do not modify this crate.** Write a convergence crate above it
  that pins the common combination.

## Core Principle

After 1.0, growth in capability comes from the appearance of new crates,
not from modification of existing ones.

## Versioning and Publishing

- Every crate has its own independent version number following semver.
- Crate-to-crate dependencies reference published versions on crates.io.
- `0.x` permits breaking changes; `1.0+` permits only additive changes.
