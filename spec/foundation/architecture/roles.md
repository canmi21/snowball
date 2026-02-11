# Crate Roles

Roles are relative, not absolute categories.
A crate's role is defined by its relationship to the crates it depends on,
not by a fixed taxonomy. The number of layers in the ecosystem is dynamic —
it emerges from how crates compose over time.

## Leaf Crate

The most fundamental building blocks. Leaf crates have no dependencies
on other snowball ecosystem crates. They come in two variants:

### Stateless Leaf

Performs a single X→Y transformation with no internal state.

**Qualification:**

1. Describable as "transform X into Y" where X and Y are expressed as type constraints.
2. Every public method is indispensable — remove any one and the rest lose independent meaning.
3. Core logic stays within the SCoL threshold (see [heuristics](../heuristics.md)).

**Diagnostic questions:**

1. Can you describe it as "transform X into Y"?
   No → responsibility is not singular; split.
   X or Y is a concrete type → insufficient generality; express as type constraint.

2. How many reasonable variants exist for X and Y?
   Combinations exceed the SCoL threshold → scope too large; split.
   Multiple branches each exceeding 10 lines → each branch should be an independent crate.

3. Remove any public method — do the remaining methods still have independent meaning?
   Yes → the removed method does not belong in this crate.
   No → granularity is correct; do not split further.

### Stateful Leaf

Manages internal mutable state without depending on other snowball crates.
Follows stateful library patterns (see [stateful-sync](../../lib/patterns/stateful-sync.md)
and [stateful-async](../../lib/patterns/stateful-async.md)).

The same qualification criteria apply at the conceptual level:
single responsibility, method indispensability, SCoL heuristic.

## Composition — Relative Definition

When crate C depends on crates A and B, C's nature is determined by what it does with them.
Composition is not a fixed category — the same crate C could be any of the following:

- **New stateless logic**: C uses A and B to implement a new X→Y transformation
  at a higher abstraction level. C itself remains a stateless, pure-function crate.
- **Type narrowing**: C re-exports and pins some type parameters from A and B,
  raising the abstraction level while leaving other parameters generic.
- **Stateful orchestration**: C introduces state to coordinate A and B,
  managing their interaction through internal concurrency or sequencing.

In all cases, the composition layer is inherently thin — it is glue and orchestration,
not core logic. The SCoL heuristic applies naturally.

When other specification files refer to "composition crate", this is shorthand
for "a crate in a composition relationship" — not a fixed category parallel to
leaf or convergence.

## Convergence — Terminal Composition

The final composition layer before a binary crate.
A convergence crate pins all remaining generic type parameters for a specific use case.

See [convergence](convergence.md) for the full rules.

Multiple convergence sets may coexist for different environments
(production, testing, embedded). The underlying crates remain unchanged.

## Binary Crate

The final application layer. Consumes convergence crates and performs orchestration.

Detailed rules in [bin layout](../../bin/structure/layout.md)
and [main/run](../../bin/structure/main-run.md).

## Crate Size

All crate roles share the same SCoL threshold.
See [heuristics](../heuristics.md) for the threshold and evaluation process.
