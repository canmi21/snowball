# Error Handling (Binary)

## Core Rule

Binary crates use opaque error aggregation exclusively.
They do not define their own structured error types.

Library errors propagate through the language's error propagation mechanism
and are automatically converted. The binary adds business context
at each significant operation.

For language-specific error handling tools, see [lang/](lang/).

## Error Flow

```
library error (structured, matchable)
    |
convergence layer (pass-through, no new error types)
    |
orchestration function adds business context
    |
entry point outputs the full error chain, then exits
```

## Rules

- Defining a structured error type in a binary crate is forbidden.
  Structured errors are a library tool for matchable errors.
  Binaries aggregate errors with an opaque error type.
- No panic-equivalent operations in binary crate code.
  All fallible operations use the language's error propagation.
  See [panic-policy](../foundation/safety/panic-policy.md) for the full rules.
- Every significant operation in the orchestration function
  receives a context annotation describing the operation in progress,
  producing a readable error chain.
- The error output format (human-readable, structured JSON,
  with or without backtrace) is the binary author's decision.
  The specification requires only that the full error chain
  is preserved and output.

## Relationship to Library Error Handling

- Library crates define structured errors
  (see [error-handling](../lib/practices/error-handling.md)).
- Binary crates aggregate all errors with opaque error types.
- The two approaches are complementary and must not be mixed:
  libraries never expose opaque errors in their public API;
  binaries never define structured error types.
