# Error Handling

## Base Rules (All Library Crates)

Every library crate defines its own `Error` enum. The following rules apply universally.

### Mandatory Attributes

- `#[non_exhaustive]` on the enum — allows additive variants in minor versions.
- `#[derive(Debug, thiserror::Error)]` — `thiserror` is the designated derive macro
  for all error types in this ecosystem.

### Structural Rules

- Every variant name is a **noun** describing what went wrong,
  not what to do about it.
- All error information is carried in **structured fields**, not strings.
- The following are **forbidden** as public error carriers:
  `Box<dyn Error>`, `anyhow::Error`, `String`.
- `anyhow` is an **application-layer privilege** — libraries never expose it
  in their public API.

### Cross-Crate Error Isolation

- A leaf crate does not know about other leaf crates' error types.
- `From` conversions between different crates' errors are written
  only in composition/glue crates, never in leaf crates.

## Recommended Variant Names

When a crate's operations involve the following scenarios,
use the recommended variant name for consistency across the ecosystem.

| Scenario              | Recommended Name | When to Include                                          |
| --------------------- | ---------------- | -------------------------------------------------------- |
| I/O failure           | `Io`             | Operations involving file, network, or system I/O        |
| Underlying timeout    | `Timeout`        | Async operations where the underlying layer may time out |
| Operation cancelled   | `Cancelled`      | Async operations that may be cancelled                   |
| Lock poisoning        | `Poisoned`       | Crates using `std` synchronization locks                 |
| Service shutting down | `ShuttingDown`   | Stateful services with a lifecycle                       |

This list is not exhaustive. As the ecosystem grows, new recommended names
will be added to this specification.

### Naming Guidelines for Unlisted Variants

- Use a **noun** that describes the failure condition.
- Do not use verbs (`FailedToConnect` → use `ConnectionFailure` or `Io`).
- Do not describe recovery actions (`RetryLater` → use `Unavailable`).
- Carry context in structured fields, not in the variant name.

## Async Library Additions

- All error variants must be `Send + Sync`.
- The library itself does **not** implement timeout logic.
  Timeout is a caller-side policy decision.
  The `Timeout` variant represents a timeout reported by the underlying layer.

## Stateful Library Additions

- **Construction errors and runtime errors are separate types.**
  Construction failure typically means the application should exit.
  Runtime errors may be retried. Different handling requires different types.

## Stateful Async Library Additions

- Inherits async rules (`Send + Sync`, `Timeout`, `Cancelled`).
- Must include `Poisoned` if using `std` synchronization locks.
- Must include `ShuttingDown` if the crate manages a service lifecycle.

## Error Chain Architecture

Each link in the error chain corresponds to a layer that made
an actual decision or transformation. Pure pass-through layers
do not appear in the chain.

### By Layer

| Layer             | Error Responsibility                                                                                 |
| ----------------- | ---------------------------------------------------------------------------------------------------- |
| Leaf crate        | Defines own `Error` enum. Uses `#[source]` to link underlying causes.                                |
| Composition crate | Defines own `Error` enum wrapping multiple lower-layer errors. Describes which sub-operation failed. |
| Convergence crate | No new error types. Re-exports or type-aliases the composition layer's errors.                       |
| Binary (`run.rs`) | Uses `anyhow` + `.context()` to add top-level business semantics.                                    |

### Decision Rule

- The layer performed an actual operation (parsing, I/O, validation) → **appears** in the chain.
- The layer is pure pass-through (convergence, re-export) → **does not appear**.
- The layer is the orchestration entry point (bin `run()`) → **appears** via `.context()`.
