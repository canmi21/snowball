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

1. Describable as "transform X into Y" where X and Y are expressed as trait bounds.
2. Every public method is indispensable — remove any one and the rest lose independent meaning.
3. Core logic stays near or under 300 lines (excluding comments, blank lines, and tests).

**Diagnostic questions:**

1. Can you describe it as "transform X into Y"?
   No → responsibility is not singular; split.
   X or Y is a concrete type → insufficient generality; express as trait bound.

2. How many reasonable variants exist for X and Y?
   Combinations exceed 300 lines of coverage → scope too large; split.
   Multiple branches each exceeding 10 lines → each branch should be an independent crate.

3. Remove any public method — do the remaining methods still have independent meaning?
   Yes → the removed method does not belong in this crate.
   No → granularity is correct; do not split further.

### Stateful Leaf

Manages internal mutable state without depending on other snowball crates.
Follows stateful library patterns (see [stateful-sync](../../lib/patterns/stateful-sync.md)
and [stateful-async](../../lib/patterns/stateful-async.md)).

The same qualification criteria apply at the conceptual level:
single responsibility, method indispensability, 300-line heuristic.

## Composition — Relative Definition

When crate C depends on crates A and B, C's nature is determined by what it does with them.
Composition is not a fixed category — the same crate C could be any of the following:

- **New stateless logic**: C uses A and B to implement a new X→Y transformation
  at a higher abstraction level. C itself remains a stateless, pure-function crate.
- **Partial convergence**: C re-exports and pins some type parameters from A and B,
  raising the abstraction level while leaving other parameters generic.
- **Stateful orchestration**: C introduces state to coordinate A and B,
  managing their interaction through internal concurrency or sequencing.

In all cases, the composition layer is inherently thin — it is glue and orchestration,
not core logic. The 300-line heuristic applies naturally.

## Convergence — Terminal Composition

The final composition layer before a binary crate.
A convergence crate pins all remaining generic type parameters for a specific use case.

### Rules

- Contains only type aliases and constructor functions.
- Contains zero logic.
- Fixes parameters that never vary across a given use-case domain.
- Preserves parameters that still vary as generics.

Multiple convergence sets may coexist for different environments
(production, testing, embedded). The underlying crates remain unchanged.

## Binary Crate

The final application layer. Consumes convergence crates and performs orchestration.

Detailed rules in [bin/](../../../bin/).

## The 300-Line Heuristic

300 lines is a thinking tool, not a hard limit.

Its purpose is to create continuous pressure: when approaching 300 lines,
ask whether the crate contains sub-logic that could be independently reusable.
If it does, extract it — that extraction becomes a new crate on the snowball.

If the logic is tightly coupled and slightly exceeds 300 lines, that is acceptable.
The heuristic serves design introspection, not mechanical enforcement.

For composition and orchestration code, staying under 300 lines should be natural —
glue code that exceeds this threshold likely has logic that belongs in a lower-level crate.
