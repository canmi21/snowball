# Trait–Implementation Separation

## Default Rule

Trait definitions and implementations live in separate crates.

A trait crate defines the capability contract (types, method signatures, bounds).
An implementation crate depends on the trait crate and provides concrete logic.

```
config-parse            → trait definition crate
config-parse-toml       → implementation crate (TOML)
config-parse-json       → implementation crate (JSON)
```

## Why Separation Is the Default

- The trait crate reaches 1.0 quickly — it contains no logic, so it rarely changes.
- New implementations are new crates, added without modifying anything existing.
- Composite crates depend only on the trait crate,
  avoiding transitive dependency on any specific implementation.
- Multiple convergence sets (production, testing, embedded) can select
  different implementations while sharing the same trait crate.

## The One Exception

A trait and its implementation may live in the same crate when — and only when —
the answer to this question is definitively **no**:

> "Would anyone ever want a different implementation of this trait?"

This applies to crates where the interface and the algorithm are inseparable —
a specific mathematical operation, a concrete encoding, a fixed-format serializer.

When in doubt, separate. The cost of managing an extra crate early on
is far lower than the cost of splitting a crate after it has dependents.
