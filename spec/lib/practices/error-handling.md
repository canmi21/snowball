# Error Handling

## Base Rules (All Library Crates)

Every library crate defines its own error type. The following rules apply universally.

For language-specific error type implementation, see [lang/](lang/).

### Structural Rules

- The error type must be extensible — adding new variants
  in a minor version must not break existing callers.
- Every variant name is a **noun** describing what went wrong,
  not what to do about it.
- All error information is carried in **structured fields**, not strings.
- Opaque error containers (type-erased errors, stringly-typed errors)
  are forbidden in library public APIs.
  Opaque errors are an application-layer privilege.

### Cross-Crate Error Isolation

- A leaf crate does not know about other leaf crates' error types.
- Error conversions between different crates' errors are written
  only in composition/glue crates, never in leaf crates.

## Recommended Variant Names

When a crate's operations involve the following scenarios,
use the recommended variant name for consistency across the ecosystem.

| Scenario              | Recommended Name | When to Include                                          |
| --------------------- | ---------------- | -------------------------------------------------------- |
| I/O failure           | `Io`             | Operations involving file, network, or system I/O        |
| Underlying timeout    | `Timeout`        | Async operations where the underlying layer may time out |
| Operation cancelled   | `Cancelled`      | Async operations that may be cancelled                   |
| Lock poisoning        | `Poisoned`       | Crates using synchronization locks                       |
| Service shutting down | `ShuttingDown`   | Stateful services with a lifecycle                       |

This list is not exhaustive. As the ecosystem grows, new recommended names
will be added to this specification.

### Naming Guidelines for Unlisted Variants

- Use a **noun** that describes the failure condition.
- Do not use verbs (`FailedToConnect` → use `ConnectionFailure` or `Io`).
- Do not describe recovery actions (`RetryLater` → use `Unavailable`).
- Carry context in structured fields, not in the variant name.

## Async Library Additions

- All error variants must be thread-safe.
- The library itself does **not** implement timeout logic.
  Timeout is a caller-side policy decision.
  The `Timeout` variant represents a timeout reported by the underlying layer.

## Stateful Library Additions

- **Construction errors and runtime errors are separate types.**
  Construction failure typically means the application should exit.
  Runtime errors may be retried. Different handling requires different types.

## Stateful Async Library Additions

- Inherits async rules (thread-safety, `Timeout`, `Cancelled`).
- Must include `Poisoned` if using synchronization locks.
- Must include `ShuttingDown` if the crate manages a service lifecycle.

## Error Chain Architecture

Each link in the error chain corresponds to a layer that made
an actual decision or transformation. Pure pass-through layers
do not appear in the chain.

### By Layer

| Layer             | Error Responsibility                                                                               |
| ----------------- | -------------------------------------------------------------------------------------------------- |
| Leaf crate        | Defines own error type. Links underlying causes through source chaining.                           |
| Composition crate | Defines own error type wrapping multiple lower-layer errors. Describes which sub-operation failed. |
| Convergence crate | No new error types. Re-exports or type-aliases the composition layer's errors.                     |
| Binary            | Adds top-level business context to errors from lower layers.                                       |

### Decision Rule

- The layer performed an actual operation (parsing, I/O, validation) → **appears** in the chain.
- The layer is pure pass-through (convergence, re-export) → **does not appear**.
- The layer is the orchestration entry point (bin `run()`) → **appears** via `.context()`.
