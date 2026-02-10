# Error Handling (Binary)

## Core Rule

Binary crates use `anyhow::Result` exclusively.
They do not define their own `Error` enums.

Library errors propagate through `?` and are automatically converted
to `anyhow::Error`. The binary adds business context via `.context()`.

## Error Flow

```
lib Error (thiserror, structured)
    | ?
convergence layer (pass-through, no new error types)
    | ?
run() adds business context via .context()
    | ?
main() outputs the full error chain, then exits
```

## Rules

- Defining an `Error` enum in a binary crate is forbidden.
  Error enums are a library tool for structured, matchable errors.
  Binaries aggregate errors with `anyhow`.
- Writing `.unwrap()` or `.expect()` in binary crate code is forbidden.
  All fallible operations use `?`.
  See [panic-policy](../foundation/safety/panic-policy.md) for the full rules.
- Every significant operation in `run()` receives a `.context()` annotation
  describing the operation in progress, producing a readable error chain.
- The error output format (human-readable, structured JSON, with or without backtrace)
  is the binary author's decision.
  The specification requires only that the full error chain is preserved and output.

## Relationship to Library Error Handling

- Library crates define structured errors with `thiserror`
  (see [error-handling](../lib/practices/error-handling.md)).
- Binary crates aggregate all errors with `anyhow`.
- The two approaches are complementary and must not be mixed:
  libraries never use `anyhow` in their public API;
  binaries never define `Error` enums.
