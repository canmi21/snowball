# CHANGELOG — Library Crates

Follows the shared format in [format](format.md).

## Category Restrictions by Phase

### 0.x (Exploration)

All five categories are permitted:
Added, Fixed, Changed, Removed, Breaking.

Every Breaking entry must include a migration note
explaining what the old usage was and what the new usage is.

```markdown
### Breaking

- Renamed `parse` to `decode`. Previously: `crate::parse(input)`. Now: `crate::decode(input)`.
```

### 1.0+ (Stable)

Only two categories are permitted: **Added** and **Fixed**.

- Changed, Removed, and Breaking must not appear.
  The API is stable; growth comes from new crates,
  not modification of existing ones
  (see [lifecycle](../lifecycle.md)).
- If a version entry would require Changed, Removed, or Breaking,
  the change does not belong in this crate.
  Create a new crate instead.
