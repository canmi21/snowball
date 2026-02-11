# Interface Design — Rust

Rust-specific implementation details for the
[interface design](../interface-design.md) specification.

## Trait Receiver

- **Default**: `&self`.
- **Exception**: `self` for `into_xxx` conversions and `build` finalization.

## Input and Output Types

- Zero-copy via lifetime parameterization:

```rust
pub trait Parser<'a> {
    type Output;
    type Error;
    fn parse(&self, raw: &'a [u8]) -> Result<Self::Output, Self::Error>;
}
```

## Object Safety

Prefer object-safe (dyn-compatible) traits for capability contracts.
This preserves the consumer's option to use `Box<dyn Trait>`.

If a method requires generics or returns `Self`, mark it
`where Self: Sized` so the remaining methods stay object-safe.

## Async Traits

- Supertrait bound: `trait Foo: Send + Sync`.
- Associated `type Error: Send`.
- Returned futures must be `Send`.
- No runtime binding — use only `std::future::Future`.
- For `Stream`, depend on `futures-core` (trait-only, no runtime binding).

```rust
pub trait Fetcher: Send + Sync {
    type Error: Send;
    fn fetch(&self, url: &str) -> impl Future<Output = Result<Vec<u8>, Self::Error>> + Send;
}
```

## Stateful Sync Traits

- `&self` methods and `&mut self` methods belong to **separate traits**.
- Method signatures must honestly reflect whether they modify state.

### Interior Mutability

No `Cell`, `RefCell`, or `Mutex` in `&self` methods
except for pure cache optimization (e.g., `OnceCell`).

## Stateful Async Traits

- **All methods use `&self`** — `&mut self` is impossible
  in concurrent contexts.
- Supertrait: `Send + Sync`. Associated `Error: Send`. Futures: `Send`.
- Interior mutability is the standard mechanism.
  Implementations use `Arc<RwLock<...>>`, channels, or other concurrency
  primitives to manage shared mutable state behind `&self`.
