# Interface Design

## Base Rules (All Interfaces)

For language-specific interface syntax, see [lang/](lang/).

### Receiver

- **Default**: shared reference — the interface represents a capability or service.
- **Exception**: consuming receiver — explicitly allowed for conversions
  and builder finalization.

### Input and Output Types

- **Input**: by reference.
- **Output**: owned by default.
- **Exception**: reference return is allowed when the interface semantically
  represents access to stored state.
- **Zero-copy**: supported by parameterizing the interface with a lifetime
  so output can borrow from input.

### Associated Error Type

- The error type is abstract — never a concrete error type.
- Let the implementor define their own error type.
- See [error-handling](../practices/error-handling.md) for error type rules.

### Interface Cohesion

Every public method in an interface must be indispensable.
Remove any one method — if the rest retain independent meaning,
the removed method does not belong in this interface.

### Third-Party Type Isolation

Interfaces depend only on standard library types or types defined
in the same package. External types are permitted only from packages
that qualify as trusted foundation dependencies.

**Evaluation process for external packages:**

1. Does a package exist that solves this problem?
2. Are its boundaries clear — does it do one thing with a well-defined scope?
3. Does its design align with the ecosystem philosophy
   (single responsibility, minimal dependencies, clean API, semver discipline)?
4. Decision:
   - **Trusted**: boundaries are clear, philosophy aligns. Use directly.
   - **Semi-trusted**: useful but has rough edges. Wrap with a thin adapter.
   - **Rewrite**: fundamentally misaligned. Implement within the ecosystem.

This is a qualitative judgment, not a numeric threshold.
Download counts and popularity are not reliable indicators —
a well-designed niche package can be trusted; a popular but bloated one cannot.

## Dynamic Dispatch Compatibility

Prefer interfaces that remain compatible with dynamic dispatch.
This preserves the consumer's option to use type-erased references.

## Default Implementations

- **Required methods** define the irreducible contract —
  decisions the implementor must make.
- **Default methods** are allowed only as derivations from required methods
  (e.g., `is_empty()` implemented as `self.len() == 0`).
- A default method may be overridden for optimization,
  but the override must not change the observable behavior.

## Async Interface Rules

- All interfaces and returned async values must be thread-safe.
- Associated error types must be thread-safe.
- No runtime binding — depend only on language-standard async primitives.

## Stateful Sync Interface Rules

- Read-only methods and mutating methods belong to **separate interfaces**.
- Callers can depend on the read-only interface without acquiring
  mutable access.
- Method signatures must honestly reflect whether they modify state.

### Interior Mutability (Sync)

Forbidden in read-only methods, with one exception: **pure cache optimization**.
A cache is pure if removing it does not affect the correctness of return
values — only performance changes.

## Stateful Async Interface Rules

- **All methods use shared (read-only) references** — mutable references
  are impossible in concurrent contexts.
- Read and write operations are still split into separate interfaces,
  but both use shared references.
- Interior mutability is the **standard mechanism** for async stateful packages.
- All interfaces and returned values must be thread-safe.
