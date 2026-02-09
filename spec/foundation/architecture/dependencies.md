# Dependency Direction

## Core Principle

A stateless crate never depends on a stateful crate.

The stateless layer is the foundation of the ecosystem.
Stateful crates (orchestration, resource management) live above it
and depend downward into the stateless layer — never the reverse.

## Within the Stateless Layer

Stateless crates may depend on other stateless crates.
This dependency is still directional: a crate depends on crates
that are more primitive than itself.

Examples of valid stateless composition:

- A field-processing crate (primitive).
- A variable-processing crate (primitive).
- A crate that combines both into variable-field processing (depends on the two above).

All three live in the stateless layer. The third depends on the first two,
not the reverse.

## Why Direction Is Natural

If every crate achieves maximum generality within its bounded scope,
dependency direction follows automatically. A well-scoped crate only needs
things more primitive than itself — it never reaches upward.

When you build a new crate, you either:

1. Depend on existing lower-level crates.
2. Write a new lower-level crate first, then compose it with existing ones.

In both cases, the dependency graph points downward.

## Exceptions

If a circular or upward dependency appears, treat it as a design signal
that the boundaries are wrong. Resolve by re-examining and re-splitting
the involved crates — not by allowing the exception.
