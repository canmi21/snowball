# Testing (Binary)

## Principle

Binary tests do not duplicate logic already tested by library crates.
The test focus is **orchestration** — whether logic blocks execute
in the correct order and whether failures are handled properly.

For the general testing philosophy that applies to both library
and binary crates, see [testing](../lib/practices/testing.md).
In particular, the principle of leveraging standard implementations
as test-only dependencies applies here as well.

## Two Test Categories

### Category 1 — Orchestration Tests

Verify the assembly and sequencing of logic blocks:

- **Call order**: logic blocks execute in the expected sequence.
- **Failure handling**: when a logic block fails, the binary responds correctly
  (propagates error, retries, skips — as designed).
- Do not re-test library input/output contracts.
  That is the library's responsibility.

For language-specific test examples, see [lang/](lang/).

### Category 2 — Integration Tests

Observe the binary's complete behavior from the outside
of the orchestration function:

- **Happy path**: valid configuration, services start and shut down cleanly.
- **Error path**: invalid configuration or simulated failures produce
  the expected overall behavior.

## Rules

- Binary tests call the orchestration function directly.
  They do not launch the binary as a process.
  This is the primary benefit of the entry point / orchestration separation
  (see [entry point and orchestration](structure/main-run.md)).
- Do not mock library internals. Libraries test themselves.
  Mock only external dependencies (database, network, filesystem).
- Every failure-handling path (propagate, retry, skip) has at least one test.

## Real Dependencies Over Mocks

At the binary level, the test-only dependency principle
(see [testing](../lib/practices/testing.md)) extends to external infrastructure:

- Prefer real dependencies in tests when practical.
  For example, use container-based test infrastructure
  to run a real database rather than mocking the database interface.
- Real dependencies verify that the binary's orchestration logic
  works against actual external systems, not just contract-conforming stubs.
- Mocks remain appropriate when real dependencies are prohibitively slow,
  non-deterministic, or unavailable in CI.
