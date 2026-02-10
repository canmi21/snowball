# Spec Change Types

Every modification to the spec is classified into one of three types.
The classification determines the impact handling strategy
(see [impact](impact.md)).

## Additive

New rules, new files, or new sections that extend the spec
without affecting existing rules.

- Existing crates are unaffected.
- New crates follow the expanded spec.
- Analogous to a minor version bump in semver.

## Corrective

Fixes to errors, elimination of contradictions, clarification of ambiguity.
The intended meaning does not change — only the precision of expression improves.

- Existing crates that happen to rely on the ambiguous interpretation
  adjust at their next version update, not immediately.
- Analogous to a patch version bump in semver.

## Breaking

A change to the behavior or requirements of an existing rule.
Crates that comply with the old rule may not comply with the new one.

- Requires a migration plan and may include a transition period.
- Analogous to a major version bump in semver.

Breaking changes to the spec are rare by design.
The snowball philosophy favors additive growth over modification.
When a breaking change is unavoidable, it is handled with the same
discipline as a breaking change in code: deliberately, transparently,
and with a clear migration path.
