# Trait Design

## Base Rules (All Traits)

### Receiver

- **Default**: `&self` — the trait represents a capability or service.
- **Exception**: `self` — explicitly allowed for conversion traits (`into_xxx`)
  and builder finalization (`build`).

### Input and Output Types

- **Input**: by reference.
- **Output**: owned by default.
- **Exception**: reference return is allowed when the trait semantically represents
  access to stored state, with the lifetime tied to `&self`.
- **Zero-copy**: naturally supported. When zero-copy is needed,
  parameterize the trait with a lifetime (`trait Parser<'a>`)
  so output can borrow from input. This is an instance of the reference-return exception.

### Associated Error Type

- `type Error` — never a concrete error type.
- Let the implementor define their own error type.
- See [error-handling](../practices/error-handling.md) for error type rules.

### Trait Cohesion

Every public method in a trait must be indispensable.
Remove any one method — if the rest retain independent meaning,
the removed method does not belong in this trait.

### Third-Party Type Isolation

Traits depend only on `std` types or types defined in the same crate.
External types are permitted only from crates that qualify as trusted
foundation dependencies.

**Evaluation process for external crates:**

1. Does a crate exist that solves this problem?
2. Are its boundaries clear — does it do one thing with a well-defined scope?
3. Does its design align with the ecosystem philosophy
   (single responsibility, minimal dependencies, clean API, semver discipline)?
4. Decision:
   - **Trusted**: boundaries are clear, philosophy aligns. Use directly.
   - **Semi-trusted**: useful but has rough edges. Wrap with a thin adapter.
   - **Rewrite**: fundamentally misaligned. Implement within the ecosystem.

This is a qualitative judgment, not a numeric threshold.
Download counts and popularity are not reliable indicators —
a well-designed niche crate can be trusted; a popular but bloated crate cannot.

## Object Safety

Prefer object-safe (dyn-compatible) traits for capability contracts.
This preserves the consumer's option to use `Box<dyn Trait>`.

If a method requires generics or returns `Self`, mark it `where Self: Sized`
so the remaining methods stay object-safe.

## Default Implementations

- **Required methods** define the irreducible contract —
  decisions the implementor must make.
- **Default methods** are allowed only as derivations from required methods
  (e.g., `is_empty()` implemented as `self.len() == 0`).
- A default method may be overridden for optimization,
  but the override must not change the observable behavior.

## Async Trait Rules

- Supertrait bound: `trait Foo: Send + Sync`.
- Associated `type Error: Send`.
- Returned futures must be `Send`.
- No runtime binding — use only `std::future::Future`.
- For `Stream`, depend on `futures-core` (trait-only, no runtime binding).

## Stateful Sync Trait Rules

- `&self` methods and `&mut self` methods belong to **separate traits**.
- Callers can depend on the read-only trait without acquiring a mutable reference.
- Method signatures must honestly reflect whether they modify state.

### Interior Mutability (Sync)

Forbidden in `&self` methods, with one exception: **pure cache optimization**.
A cache is pure if removing it does not affect the correctness of return values —
only performance changes.

## Stateful Async Trait Rules

- **All methods use `&self`** — `&mut self` is impossible in concurrent contexts.
- Read and write operations are still split into separate traits,
  but both use `&self`.
- Interior mutability is the **standard mechanism** for async stateful crates.
  Implementations use `Arc<RwLock<...>>`, channels, or other concurrency primitives
  to manage shared mutable state behind `&self`.
- Supertrait: `Send + Sync`. Associated `Error: Send`. Futures: `Send`.
