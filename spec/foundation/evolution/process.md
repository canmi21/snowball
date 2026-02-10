# Spec Change Process

The spec is maintained by a single maintainer.
The process is lightweight but disciplined.

## Steps

### 1. Record the Trigger

Document why the change is needed, referencing
one of the trigger categories (see [triggers](triggers.md)).

### 2. Assess Impact

Determine the change type: additive, corrective, or breaking
(see [types](types.md)).

Identify which spec files are affected.
For breaking changes, identify which existing crates are affected.

### 3. Modify Spec Files

Edit the spec files directly in the monorepo.
Each change is tracked through git commits following the
[commit message rules](../git/commit-message.md).

### 4. Update Spec CHANGELOG

The spec maintains its own CHANGELOG recording every modification.
Each entry includes:

- Date.
- Change type (additive / corrective / breaking).
- Which files were modified.
- Brief description of the change and its rationale.

### 5. Additional Steps for Breaking Changes

Breaking changes require extra work before the change is finalized:

- **Migration guide**: a description of what existing crates
  must change to comply with the new rule.
- **Affected crate list**: which monorepo crates need adjustment.
- **Transition period** (optional): a defined window during which
  both old and new rules are accepted.
  After the transition period ends, all crates must comply
  with the new rule.
