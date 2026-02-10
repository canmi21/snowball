# Testing

## Three Layers

Every crate's test suite is organized into three layers,
ordered by when they must exist and how they execute.

### Layer 1 — Happy Path

Tests that verify correct inputs produce correct outputs.

- Must be written when the crate is born.
- Must achieve 100% coverage of all documented input→output contracts.
- Runs once, deterministic, pass/fail.

### Layer 2 — Error Path

Tests that verify incorrect or boundary inputs produce proper errors.

- Must be written when the crate is born.
- Must achieve 100% coverage of all documented error conditions.
- Runs once, deterministic, pass/fail.

### Layer 3 — Fuzz

Long-running collision and edge-case discovery.

- May be deferred — added when the crate's stability warrants the investment.
- Runs continuously; results emerge over time.
- Findings from fuzz testing feed back as Layer 1 or Layer 2 regression tests.

## Relationship to Type Contracts

Complete Layer 1 + Layer 2 coverage implicitly defines all accepted input types
and all possible output types. The test suite serves as executable type documentation —
if the tests are comprehensive, the type boundaries are unambiguous.

## Test-Only Dependencies — Leverage Standard Implementations

Test-only dependencies do not enter the final artifact.
This zero-cost property should be exploited aggressively.

When a standard, well-established implementation exists for the domain
a crate operates in, depend on it in tests as a reference counterpart.

**Benefits:**

- **Interoperability verification**: if your implementation works against
  a known-good standard implementation, it is likely correct.
- **Specification compliance**: the standard implementation serves as
  a living specification. Compatibility with it implies compliance.
- **Edge case discovery**: standard implementations exercise code paths
  that hand-written test cases may miss.

**Scope:**

- Protocol and format crates: use standard implementations as the other end
  (e.g., test a QUIC implementation against an established QUIC library,
  test an HTTP parser against an established HTTP library).
- Data processing crates: use reference implementations to validate output
  against known-correct results.
- Binary crates: prefer real dependencies over mocks where practical
  (e.g., a real database via containers instead of a mock DB interface).
  See [bin testing](../../bin/testing.md) for bin-specific details.

This principle supplements, not replaces, the three test layers.
Standard implementations are primarily useful in Layer 1 (happy path)
and Layer 2 (error path) for validating correctness against a reference.
