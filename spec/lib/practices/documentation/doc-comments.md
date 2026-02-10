# Doc Comments

Follows the general rules in [general](general.md).

For language-specific doc comment syntax and lints, see [lang/](lang/).

## Library Crates

### Mandatory (All Phases, Including 0.x)

Every public item (function, type, interface, method) must have
a doc comment containing:

1. **One-line summary** — what it does.
2. **Error conditions** (if it can fail) — which inputs or states
   produce which error variants.
3. **Minimal example** — also serves as a compile-time or runtime test
   where the language supports it.

Documentation coverage is enforced from initial development onward.
Discipline starts at the beginning, not at stabilization.

## Binary Crates

- Entry point — no doc comments needed.
- Orchestration function — brief description of its orchestration role.
- Configuration type — every field must document its meaning and default value.
- Telemetry setup — document the replaceable subscriber strategy.

## Forbidden

- Doc comments on private functions (unless the logic is non-obvious).
- Implementation details in doc comments.
