# Naming — Common Rules

## Principle

All names in the snowball ecosystem follow the same base conventions.
Domain-specific naming adds constraints on top of these common rules.

## Rules

- Lowercase letters and hyphens only.
  No uppercase, no underscores, no camelCase.
- Hyphens separate words: `config-parse`, not `config_parse`.
- Names describe what the thing is, not how it is used.

## Prefix Promotion

When multiple items share a common prefix, promote the prefix
to a directory.

Before:

```
check-spec.sh
check-code.sh
check-links.sh
```

After:

```
check/
├── spec.sh
├── code.sh
└── links.sh
```

A shared prefix signals that a grouping concept exists
and should be made explicit in the hierarchy.

For file and directory application of this rule,
see [file-structure](file-structure.md).

## Domain-Specific Rules

- File and directory naming: [file-structure](file-structure.md).
- Crate naming: [crate](crate.md).
