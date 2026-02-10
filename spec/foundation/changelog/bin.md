# CHANGELOG — Binary Crates

Follows the shared format in [format](format.md).

## Category Restrictions by Phase

Same as [library crates](lib.md):
all five categories in 0.x, only Added and Fixed after 1.0.

## Additional Content

Binary crate CHANGELOGs may include deployment-relevant information
that would not appear in a library CHANGELOG:

- Configuration format changes (new fields, renamed fields, changed defaults).
- Migration steps required when upgrading.
- Changes to startup behavior, shutdown behavior, or signal handling.

These deployment notes belong under the appropriate category
(typically Changed or Breaking in 0.x, or Added/Fixed in 1.0+).
