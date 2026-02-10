# Architecture — Rust

Rust-specific practices for the architecture specifications
under [architecture](../).

## Type Flow

Examples for the [type flow](../type-flow.md) model.

Associated types connect crates:

```rust
pub trait Parser {
    type Output;
    type Error;
    fn parse(&self, raw: &[u8]) -> Result<Self::Output, Self::Error>;
}
```

Composition through `where` clauses:

```rust
fn load<P, V>(parser: &P, validator: &V, raw: &[u8]) -> Result<P::Output, ...>
where
    P: Parser,
    V: Validator<P::Output>,
{
    let data = parser.parse(raw)?;
    validator.validate(&data)?;
    Ok(data)
}
```

Vocabulary traits use `Send` bounds for async compatibility:

```rust
pub trait ConfigData: Send {
    fn get_field(&self, name: &str) -> Option<&str>;
}
```

## Repository

From the [repository model](../repository.md):

Crates are published to [crates.io](https://crates.io).
Inter-crate dependencies use crates.io versions,
**not** `path = "../..."` workspace references.

## Workspace Root Config

From the [directory structure](../directory.md):

- `Cargo.toml` — Workspace members, shared dependencies and lints.
- `rustfmt.toml` — Formatting rules.
- `clippy.toml` — Lint configuration.

Crate internal structure:

```
my-crate/
├── Cargo.toml
├── src/
│   └── lib.rs
└── tests/
    └── integration.rs
```
