# Convergence

## Definition

A convergence crate pins generic type parameters for a specific use case.
It is the terminal composition layer before a binary crate.

## Rules

A convergence crate contains:

- Type aliases that fix previously-generic parameters to concrete types.
- Constructor functions that instantiate the pinned types.

A convergence crate does **not** contain:

- Logic of any kind (no computation, no orchestration, no state).
- Orchestration belongs either in a dedicated composition crate
  or in the binary's `run.rs`.

## When to Create a Convergence Crate

When certain crates are repeatedly composed together with the same type parameters,
the repetition is a signal to write a convergence crate.

Do not create convergence crates preemptively.
Wait for the repetition signal from actual usage.

## Convergence Granularity

- Parameters that never vary across a use-case domain → fix them.
- Parameters that still vary → preserve them as generics.

## Multiple Convergence Sets

Different environments may require different concrete type selections:

```
production  → convergence crate A (selects production implementations)
testing     → convergence crate B (selects mock/stub implementations)
embedded    → convergence crate C (selects no-std implementations)
```

The underlying library crates remain completely unchanged.

## Stability

Because a convergence crate contains zero logic,
it can reach 1.0 quickly and rarely needs modification.
Changes only occur when the available implementations change,
not when logic evolves.
