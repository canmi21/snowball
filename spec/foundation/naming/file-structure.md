# Naming — File Structure

Rules for naming and organizing files and directories.

## File Naming

Snowball-controlled files use kebab-case:
spec files, documentation, scripts, configuration.

Source code files follow the language's native convention:

| Language   | Convention      | Example           |
| ---------- | --------------- | ----------------- |
| Rust       | `snake_case.rs` | `config_parse.rs` |
| TypeScript | `kebab-case.ts` | `config-parse.ts` |
| Go         | `snake_case.go` | `config_parse.go` |

This list grows as new languages join the ecosystem.

## Directory Naming

- Lowercase letters and hyphens only.
- Directory name matches the concept it represents.
- No generic names: avoid `misc`, `other`, `stuff`.

## Structural Organization

- Short topic → single file.
- Growing topic → directory with focused subfiles.
- Apply [prefix promotion](common.md) when items share a common prefix.

## Scaling Pattern

When a file grows beyond its threshold
(see [heuristics](../heuristics.md)), split it into a directory:

1. Create a directory with the same name as the file (minus extension).
2. Move content into focused subfiles within the directory.
3. Update all references to the old file path.

The directory depth threshold is defined in
[heuristics](../heuristics.md).
