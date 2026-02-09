# Type Flow

## Principle

Types flow between crates through associated types and trait bounds.
The compiler verifies type compatibility across the entire composition chain.
Manual type conversion between crates should be unnecessary in the common case.

## Primary Mechanism — Associated Types

Each capability trait declares its input and output types as associated types:

```rust
pub trait Parser {
    type Output;
    type Error;
    fn parse(&self, raw: &[u8]) -> Result<Self::Output, Self::Error>;
}
```

Composition crates connect types through `where` clauses:

```rust
fn load<P, V>(parser: &P, validator: &V, raw: &[u8]) -> Result<P::Output, ...>
where
    P: Parser,
    V: Validator<P::Output>,  // P's output feeds directly into V's input
{
    let data = parser.parse(raw)?;
    validator.validate(&data)?;
    Ok(data)
}
```

The type chain is verified at compile time. No runtime conversion needed.

## Supplementary Mechanism — Vocabulary Traits

When unrelated crates need to agree on the shape of data
without depending on each other's types, define a vocabulary trait:

```rust
/// Describes the shape of configuration data.
/// Any type satisfying this trait can flow between config-related crates.
pub trait ConfigData: Send {
    fn get_field(&self, name: &str) -> Option<&str>;
}
```

Vocabulary traits belong in trait-definition crates (the same crates that define
capability traits, or in dedicated vocabulary crates if the shape is cross-domain).

### When to Use Vocabulary Traits

Use a vocabulary trait only when:

- Two or more crates need to share a data-shape contract.
- These crates do not already share a capability trait whose associated types
  would naturally connect them.

If the type chain can be expressed purely through associated types
on existing capability traits, do not introduce a vocabulary trait.

## Adapter — Last Resort

When two existing crates have genuinely incompatible types,
write an adapter in the composition layer:

- A newtype wrapper or conversion function.
- This is the only place where cross-crate type conversion is permitted.
- Leaf crates and convergence crates never contain cross-crate adapters.
