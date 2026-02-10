# Snowball Monorepo

This is the snowball ecosystem — a composable, incrementally-growing
collection of crates governed by a specification.

## Spec

All rules live in `spec/`. Read [spec/README.md](spec/README.md) for the full index.
Current spec version: [spec/VERSION](spec/VERSION).

Never rely on assumptions. If the spec defines a rule, follow it exactly.
If the spec does not cover something, evolve the spec first, then act.

## Concepts

| Concept     | What it is                                                                                 | Spec                                                       |
| ----------- | ------------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| Leaf        | Lowest-level crate, no snowball dependencies                                               | [roles](spec/foundation/architecture/roles.md)             |
| Composition | Combines lower crates, relative relationship                                               | [roles](spec/foundation/architecture/roles.md)             |
| Convergence | Pins generics for a use case, zero logic                                                   | [convergence](spec/foundation/architecture/convergence.md) |
| Binary      | Application entry point, orchestration                                                     | [structure](spec/bin/structure/layout.md)                  |
| Naming      | Lowercase + hyphens, prefix promotion, per-domain rules                                    | [naming](spec/foundation/naming/common.md)                 |
| Heuristics  | All numeric limits (100 lines, 300 SCoL, 4 depth) are evaluation triggers, not hard limits | [heuristics](spec/foundation/heuristics.md)                |

## Context Detection

| Working in                | Read first                                                                                                                         |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `library/`                | [lib patterns](spec/lib/patterns/) + [practices](spec/lib/practices/) + [convergence](spec/foundation/architecture/convergence.md) |
| `bin/` (application repo) | [bin spec](spec/bin/)                                                                                                              |
| `spec/`                   | [evolution](spec/foundation/evolution/) + [writing-style](spec/foundation/writing-style.md) + [naming](spec/foundation/naming/)    |
| `tools/`                  | [compliance](spec/foundation/compliance.md)                                                                                        |
| root config               | [git](spec/foundation/git/) + [publication](spec/foundation/publication/)                                                          |

Directory structure follows snowball hierarchy:
[directory](spec/foundation/architecture/directory.md).

## Core Rules

1. **Never assume.** Follow the spec. If unsure, read the spec file.
2. **Spec gap?** Do not improvise. Evolve the spec first
   ([evolution process](spec/foundation/evolution/process.md)),
   then implement.
3. **User conflicts with spec?** Must be resolved explicitly.
   The resolution may trigger a spec modification.
4. **Modifying the spec?** Pragmatic behavior is allowed during
   the modification. Once the spec is updated, return to strict compliance.
5. **Commit rules:** [commit-message](spec/foundation/git/commit-message.md),
   [commit-scope](spec/foundation/git/commit-scope.md),
   [branching](spec/foundation/git/branching.md).
6. **Error handling:** Libraries use `thiserror`, binaries use `anyhow`.
   Never mix. [lib](spec/lib/practices/error-handling.md) /
   [bin](spec/bin/error-handling.md).
7. **No panic code.** No `unwrap`, `expect`, `panic!`.
   [panic-policy](spec/foundation/safety/panic-policy.md).

## Self-Hosting

The spec has reached self-hosting. All modifications follow the
[evolution process](spec/foundation/evolution/process.md).
Bootstrap history is [archived](spec/archived/bootstrap.md).
