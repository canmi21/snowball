# Writing Style

These rules apply to the specification itself, code comments,
documentation, commit messages, and all written communication
within the ecosystem.

## Language

- Specification files are written in English.
- Use declarative sentence structure. State facts and rules directly.
- No emoji. No decorative formatting.
- Terminology: use "library crate" in prose, "lib" in code contexts
  (scope identifiers, directory names, file names, feature flags).

## Tone

- Formal and precise.
- Rules are stated as imperatives ("Do X", "Never Y") or declaratives ("X is required").
- Rationale follows the rule, not the other way around.

## Discussion Language

- Primary: Chinese.
- Technical terms and identifiers remain in English.
- Final written artifacts (spec files, doc comments, commit messages) are in English.

## Structure

### Single Source of Truth

Every concept is defined in exactly one place.
All other references link to that definition.
Never duplicate a rule — if two domains share a rule,
define it once in a shared location and link from both.

### File Size

Each spec file should be under 100 lines.
If a file grows beyond this, split it into a directory
with focused subfiles — the same scaling pattern
used for code modules (see [layout](../bin/structure/layout.md)).

### Abstraction Hierarchy

Universal concepts that apply to all programming
are defined at the foundation level.
Domain-specific rules (lib, bin, spec) link to the foundation definition
and append only what is unique to that domain.

Entry points are abstract and concise.
Details live in linked subfiles, not inline.

### Organization

- Short topic → single file.
- Growing topic → directory with focused subfiles.
- Nesting depth stays under 4 levels.
