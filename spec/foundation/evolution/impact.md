# Impact on Existing Crates

When the spec changes, existing crates are handled differently
depending on the change type (see [types](types.md)).

## Additive Change

- Existing crates require no action.
- Only newly created crates follow the expanded rules.
- Existing crates may optionally adopt new rules
  at the maintainer's discretion during normal development.

## Corrective Change

- Existing crates that happen to depend on the corrected ambiguity
  adjust at their next version update.
- Immediate retroactive adjustment is not required.
- The next time a crate is modified for any reason,
  the corrected rule applies.

## Breaking Change

- The maintainer creates a migration plan specifying:
  - Which crates are affected.
  - What each crate must change.
  - The timeline for completion.
- A transition period may be defined during which
  both old and new rules coexist.
  During this period, existing crates under the old rule
  are not considered non-compliant.
- After the transition period ends,
  all crates must conform to the new rule.
  Non-compliant crates are updated before their next publication.

## Principle

The spec evolves like the codebase it governs:
additive growth is preferred, breaking change is the last resort,
and when breaking change is necessary, it is managed with
explicit planning and a clear migration path.
