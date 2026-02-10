# Spec Change Triggers

A spec modification is warranted when one of the following conditions arises.

## 1. Practice Feedback

A rule is discovered to be impractical or unenforceable
during actual crate development.
The development experience itself is the primary feedback loop.

## 2. Contradiction

Two or more existing rules conflict with each other.
The spec must be internally consistent at all times.

## 3. New Domain

The ecosystem expands into a domain not covered by existing rules
(e.g., WASM targets, GPU compute, embedded with custom allocators).
New rules or new pattern files are needed.

## 4. Toolchain Change

A language edition update, a new linter rule, or a change in formatter defaults
affects existing rules. The spec adapts to stay aligned with the toolchain.

For language-specific trigger examples, see the relevant `lang/` spec.

## 5. External Dependency Evolution

A key dependency introduces a major version change that alters
the assumptions behind existing rules.
The spec is reviewed for compatibility.
