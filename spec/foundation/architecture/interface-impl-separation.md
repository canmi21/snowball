# Interface–Implementation Separation

## Default Rule

Interface definitions and implementations live in separate crates.

An interface crate defines the capability contract (types, method signatures, bounds).
An implementation crate depends on the interface crate and provides concrete logic.

```
config-parse            → interface definition crate
config-parse-toml       → implementation crate (TOML)
config-parse-json       → implementation crate (JSON)
```

## Why Separation Is the Default

- The interface crate reaches 1.0 quickly — it contains no logic, so it rarely changes.
- New implementations are new crates, added without modifying anything existing.
- Composite crates depend only on the interface crate,
  avoiding transitive dependency on any specific implementation.
- Multiple convergence sets (production, testing, embedded) can select
  different implementations while sharing the same interface crate.

## The One Exception

An interface and its implementation may live in the same crate when — and only when —
the answer to this question is definitively **no**:

> "Would anyone ever want a different implementation of this interface?"

This applies to crates where the interface and the algorithm are inseparable —
a specific mathematical operation, a concrete encoding, a fixed-format serializer.

When in doubt, separate. The cost of managing an extra crate early on
is far lower than the cost of splitting a crate after it has dependents.
