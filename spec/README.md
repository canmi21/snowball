# Snowball Specification Index

Current version: [VERSION](VERSION) |
[CHANGELOG](CHANGELOG.md)

## Foundation

### Architecture

- [roles](foundation/architecture/roles.md) — Crate roles: leaf, composition, convergence, binary.
- [convergence](foundation/architecture/convergence.md) — Terminal composition layer rules.
- [dependencies](foundation/architecture/dependencies.md) — Dependency direction: stateless never depends on stateful.
- [repository](foundation/architecture/repository.md) — Monorepo vs application repo separation.
- [trait-impl-separation](foundation/architecture/trait-impl-separation.md) — Traits and implementations in separate crates.
- [type-flow](foundation/architecture/type-flow.md) — Associated types, vocabulary traits, adapters.
- [directory](foundation/architecture/directory.md) — Monorepo layout by crate role.

### Lifecycle

- [lifecycle](foundation/lifecycle.md) — Three phases: exploration (0.x), stability (1.0), convergence.

### Writing Style

- [writing-style](foundation/writing-style.md) — Language, tone, structure rules, LLM compliance.

### Naming

- [common](foundation/naming/common.md) — Universal naming conventions, prefix promotion.
- [file-structure](foundation/naming/file-structure.md) — File and directory naming and organization.
- [crate](foundation/naming/crate.md) — Crate naming by role.

### Heuristics

- [heuristics](foundation/heuristics.md) — Threshold philosophy: 100 lines, 300 SCoL, 4 depth.

### Agent

- [agent/overview](foundation/agent/overview.md) — Sub-agent definition: frontmatter, file location, memory.
- [agent/model-selection](foundation/agent/model-selection.md) — Model selection rules by task complexity.
- [agent/first-rule](foundation/agent/first-rule.md) — Spec-first principle: stop on gaps, never improvise.
- [agent/creation](foundation/agent/creation.md) — Interactive creation process with user approval.
- [agent/registry](foundation/agent/registry.md) — Agent inventory table.

### Compliance

- [compliance](foundation/compliance.md) — Two-layer checking: shell scripts + LLM agent.

### Publication

- [checklist](foundation/publication/checklist.md) — 9-step pre-publish checklist.
- [versioning](foundation/publication/versioning.md) — Semver rules for code crates.
- [contribution](foundation/publication/contribution.md) — Single maintainer, PR rules, new crate proposals.

### Safety

- [panic-policy](foundation/safety/panic-policy.md) — No intentional panic code. Startup boundary.
- [unsafe-code](foundation/safety/unsafe-code.md) — Three categories: safe-by-default, FFI, performance.
- [dependency](foundation/safety/dependency.md) — Minimal deps, cargo-audit, review process.

### Evolution

- [triggers](foundation/evolution/triggers.md) — Five trigger types for spec changes.
- [types](foundation/evolution/types.md) — Additive, corrective, breaking.
- [process](foundation/evolution/process.md) — Fast path vs full path.
- [impact](foundation/evolution/impact.md) — Per-type handling for existing crates.

### CHANGELOG

- [format](foundation/changelog/format.md) — Five categories, Keep a Changelog based.
- [lib](foundation/changelog/lib.md) — Library crate CHANGELOG rules.
- [bin](foundation/changelog/bin.md) — Binary crate CHANGELOG rules.
- [spec](foundation/changelog/spec.md) — Spec CHANGELOG rules, timestamp versioning.

### Git

- [commit-message](foundation/git/commit-message.md) — 11 types, format, scope.
- [commit-scope](foundation/git/commit-scope.md) — Granularity, cross-area rules.
- [branching](foundation/git/branching.md) — Trunk-based, fixup+autosquash, tags.
- [lib](foundation/git/lib.md) — Library crate git rules.
- [bin](foundation/git/bin.md) — Binary crate git rules.
- [spec](foundation/git/spec.md) — Spec git rules.

## Library Crates

### Patterns

- [stateless-sync](lib/patterns/stateless-sync.md) — Pure functions, no state, no I/O.
- [stateless-async](lib/patterns/stateless-async.md) — Pure function + async I/O.
- [stateful-sync](lib/patterns/stateful-sync.md) — Mutable state, typestate, builder.
- [stateful-async](lib/patterns/stateful-async.md) — State + async + concurrency.

### Contract

- [trait-design](lib/contract/trait-design.md) — Receiver, types, cohesion, object safety, async.

### Practices

- [error-handling](lib/practices/error-handling.md) — thiserror, Error enum, error chain.
- [testing](lib/practices/testing.md) — Three layers, dev-dependency philosophy.
- [naming](lib/practices/naming.md) — Crate naming by role.
- [feature-flag](lib/practices/feature-flag.md) — Capability presence, not behavioral variation.
- [observability](lib/practices/observability.md) — Zero logging, span instrumentation only.
- [no-std](lib/practices/no-std.md) — Three capability tiers, feature gate pattern.
- [documentation/general](lib/practices/documentation/general.md) — Universal comment/doc rules.
- [documentation/doc-comments](lib/practices/documentation/doc-comments.md) — Rustdoc, clippy lints.
- [documentation/code-comments](lib/practices/documentation/code-comments.md) — SAFETY, TODO/FIXME.

## Binary Crates

- [structure/layout](bin/structure/layout.md) — Two categories, file layout, scaling, naming.
- [structure/main-run](bin/structure/main-run.md) — main.rs, run.rs, async runtime, dependency path.
- [assembly](bin/assembly.md) — Manual DI, explicit params, no DI framework.
- [config](bin/config.md) — Priority, load() boundary, structural rules.
- [telemetry](bin/telemetry.md) — Two-step init, replaceable subscriber.
- [shutdown](bin/shutdown.md) — Graceful shutdown, cancellation, timeout.
- [error-handling](bin/error-handling.md) — anyhow only, no Error enums.
- [testing](bin/testing.md) — Orchestration tests, integration tests, real dependencies.

## Archived

- [archived/README](archived/README.md) — Historical records from before self-hosting.
- [archived/bootstrap](archived/bootstrap.md) — Bootstrap phase rules (no longer in effect).
