# Spec Change Process

The spec is maintained by a single maintainer.
The process is lightweight but disciplined.

## Two Paths

### Fast Path — Additive and Corrective Changes

For changes that extend the spec or fix errors without altering
existing requirements:

1. Modify the spec files directly.
2. Update the spec CHANGELOG with the new timestamp and description.
3. Update [VERSION](../../VERSION).

No formal review required. The maintainer applies the change directly.

### Full Path — Breaking Changes

For changes that alter existing requirements and may affect
compliant crates:

1. **Record the trigger** — reference one of the
   [trigger categories](triggers.md).
2. **Assess impact** — determine which spec files and existing crates
   are affected (see [types](types.md) and [impact](impact.md)).
3. **Migration guide** — describe what existing crates must change.
4. **Modify spec files** — edit directly in the monorepo.
   Each change is tracked through git commits following the
   [commit message rules](../git/commit-message.md).
5. **Update spec CHANGELOG** — entry includes the timestamp,
   affected files, and a reference to the migration guide.
6. **Update [VERSION](../../VERSION).**
7. **Transition period** (optional) — a defined window during which
   both old and new rules are accepted.

## CHANGELOG Entry Content

Each CHANGELOG entry includes:

- Timestamp (the new spec version).
- Change type (additive / corrective / breaking).
- Which files were modified.
- Brief description of the change and its rationale.

## LLM Compliance

When an LLM agent modifies the spec, it must immediately comply
with the updated rules from that point forward.
If a conflict arises between the new rule and work in progress,
the user resolves the conflict and the resolution may trigger
a further spec modification.
