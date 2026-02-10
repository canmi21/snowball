# Stateless Sync Library

The most fundamental library type. Pure functions: same input always produces same output.

## Definition (all conditions must hold)

- All public functions are pure.
- No mutable state, no global or shared state.
- No I/O (no file access, no network, no environment variables).
- No background threads or concurrent execution.
- Synchronous return only.

## File Structure

Separate concerns into distinct files:

- **Entry point**: module declarations and explicit re-exports only.
- **Types**: input, output, and error type definitions.
- **Interfaces**: interface definitions (if this package defines a capability).
- **Core logic**: the only file permitted to contain business code.
- **Tests**: integration tests.

For language-specific file layout, see [lang/](lang/).

## Core Logic Constraints

- Stays within the SCoL threshold (see [heuristics](../../foundation/heuristics.md)).
- No panic-equivalent operations
  (see [panic policy](../../foundation/safety/panic-policy.md)).
- No logging, no printing.
- No environment variable reads or global configuration access.

## Checklist

- SS-1. Entry point contains only declarations and re-exports.
- SS-2. All public functions produce identical output for identical input.
- SS-3. Error type is a tagged, extensible enum.
- SS-4. No panic-equivalent operations.
- SS-5. No I/O, no global state, no logging.
- SS-6. Core logic stays within the SCoL threshold.
- SS-7. Every public function has a happy-path test.
- SS-8. Every error variant has an error-path test.
- SS-9. All public items have documentation with examples.
- SS-10. No async runtime or logging framework in dependencies.
