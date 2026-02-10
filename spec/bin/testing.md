# Testing (Binary)

## Principle

Binary tests do not duplicate logic already tested by library crates.
The test focus is **orchestration** — whether logic blocks execute
in the correct order and whether failures are handled properly.

For the general testing philosophy that applies to both library
and binary crates, see [testing](../lib/practices/testing.md).
In particular, the principle of leveraging standard implementations
as dev-dependencies applies here as well.

## Two Test Categories

### Category 1 — Orchestration Tests

Verify the assembly and sequencing of logic blocks:

- **Call order**: logic blocks execute in the expected sequence.
- **Failure handling**: when a logic block fails, the binary responds correctly
  (propagates error, retries, skips — as designed).
- Do not re-test library input/output contracts.
  That is the library's responsibility.

```rust
#[tokio::test]
async fn config_load_failure_prevents_startup() {
    let bad_config = Config { /* invalid */ };
    let result = run(bad_config).await;
    assert!(result.is_err());
}
```

### Category 2 — Integration Tests

Observe the binary's complete behavior from the outside of `run()`:

- **Happy path**: valid configuration, services start and shut down cleanly.
- **Error path**: invalid configuration or simulated failures produce
  the expected overall behavior.

```rust
#[tokio::test]
async fn full_startup_and_shutdown() {
    let config = test_config();
    let handle = tokio::spawn(run(config));
    // Send shutdown signal
    // Verify clean exit
}
```

## Rules

- Binary tests call `run()` directly. They do not launch the binary as a process.
  This is the primary benefit of the main/run separation
  (see [main/run](structure/main-run.md)).
- Do not mock library internals. Libraries test themselves.
  Mock only external dependencies (database, network, filesystem).
- Every failure-handling path (propagate, retry, skip) has at least one test.

## Real Dependencies Over Mocks

At the binary level, the dev-dependency principle
(see [testing](../lib/practices/testing.md)) extends to external infrastructure:

- Prefer real dependencies in tests when practical.
  For example, use `testcontainers` to run a real database
  rather than mocking the database interface.
- Real dependencies verify that the binary's orchestration logic
  works against actual external systems, not just contract-conforming stubs.
- Mocks remain appropriate when real dependencies are prohibitively slow,
  non-deterministic, or unavailable in CI.
