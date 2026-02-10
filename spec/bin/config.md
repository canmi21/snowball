# Configuration

## Priority (Highest to Lowest)

1. **CLI arguments** — explicit user intent, highest trust.
2. **Configuration file** — persistent, auditable settings.
3. **Environment variables** — lowest priority due to injection risk
   in shared or containerized environments.

A value set by a higher-priority source is never overridden
by a lower-priority source.

## Configuration Module Responsibilities

- Define configuration as strongly typed structures.
  No string-keyed maps as the public configuration type.
- Provide a `load()` function that merges sources in priority order
  and returns the configuration or an error.
- All validation completes inside `load()`.
  If `load()` succeeds, the configuration is fully valid.

## The load() Boundary

`load()` is a transformation boundary.

Internally, the loading process may use dynamic structures
(maps, untyped values, or any intermediate representation)
for merging, overlaying, and key lookup.
These are implementation details of the config parsing mechanism.

The output — the `Config` struct returned by `load()` — is always
a strongly typed, fully validated value.
Everything downstream of `load()` sees only the typed struct.

## Structural Rules

- Configuration types are pure data: no methods, no behavior.
- Nest by subsystem. Flat top-level types with dozens of fields are forbidden.
- Sensitive fields (passwords, tokens) must not appear in debug output.
  Either exclude them from the debug representation
  or implement a custom one that redacts the value.

For language-specific configuration examples, see [lang/](lang/).

## Failure Semantics

Configuration loading failure prevents startup.
Silent fallback to default values is forbidden.

If a field has a meaningful default, express it in the type definition
so the default is explicit and auditable, not hidden in fallback logic.

## Implementation

This specification defines behavioral requirements.
The snowball ecosystem will provide config crates that satisfy these requirements.
Binary crates are expected to use the ecosystem's config solution
when available, though the spec does not bind to a specific library.
