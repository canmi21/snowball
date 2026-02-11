# Type Flow

## Principle

Types flow between crates through associated types and type constraints.
The compiler verifies type compatibility across the entire composition chain.
Manual type conversion between crates should be unnecessary in the common case.

## Primary Mechanism — Associated Types

Each capability interface declares its input and output types
as associated types (or equivalent generic type parameters).
Composition packages connect types through generic constraints,
so the type chain is verified at compile time with no runtime
conversion needed.

For language-specific examples, see the relevant `lang/` spec.

## Supplementary Mechanism — Vocabulary Interfaces

When unrelated packages need to agree on the shape of data
without depending on each other's types, define a vocabulary interface
that describes the data shape.

Vocabulary interfaces belong in interface-definition packages
(the same packages that define capability interfaces,
or in dedicated vocabulary packages if the shape is cross-domain).

### When to Use Vocabulary Interfaces

Use a vocabulary interface only when:

- Two or more crates need to share a data-shape contract.
- These crates do not already share a capability interface whose associated types
  would naturally connect them.

If the type chain can be expressed purely through associated types
on existing capability interfaces, do not introduce a vocabulary interface.

## Adapter — Last Resort

When two existing crates have genuinely incompatible types,
write an adapter in the composition layer:

- A newtype wrapper or conversion function.
- This is the only place where cross-crate type conversion is permitted.
- Leaf crates and convergence crates never contain cross-crate adapters.
