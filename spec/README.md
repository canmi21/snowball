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

### VCS

- [strategy](foundation/vcs/strategy.md) — jj colocated model, repository topology, nested isolation.
- [shared-config](foundation/vcs/shared-config.md) — Symlink rules, workspace config inheritance.
- [commit-message](foundation/vcs/commit-message.md) — 11 types, format, scope, jj workflow.
- [commit-scope](foundation/vcs/commit-scope.md) — Granularity, cross-area rules.
- [bookmarks](foundation/vcs/bookmarks.md) — Trunk-based, task bookmarks, history cleanup, tags.
- [lib](foundation/vcs/lib.md) — Library crate VCS rules.
- [bin](foundation/vcs/bin.md) — Binary crate VCS rules.
- [spec](foundation/vcs/spec.md) — Spec VCS rules.

### Rust (lang/rust.md in each concept directory)

- [architecture/lang/rust](foundation/architecture/lang/rust.md) — Rust trait examples, crates.io, workspace config.
- [naming/lang/rust](foundation/naming/lang/rust.md) — crates.io availability, runtime naming.
- [safety/lang/rust](foundation/safety/lang/rust.md) — .unwrap(), .expect(), panic!(), unsafe, cargo audit.
- [publication/lang/rust](foundation/publication/lang/rust.md) — Pre-publish checklist, qwq fmt, qwq lint.
- [evolution/lang/rust](foundation/evolution/lang/rust.md) — Rust edition, clippy, tokio, thiserror triggers.

## Library Crates

### Patterns

- [stateless-sync](lib/patterns/stateless-sync.md) — Pure functions, no state, no I/O.
- [stateless-async](lib/patterns/stateless-async.md) — Pure function + async I/O.
- [stateful-sync](lib/patterns/stateful-sync.md) — Mutable state, typestate, builder.
- [stateful-async](lib/patterns/stateful-async.md) — State + async + concurrency.

### Contract

- [trait-design](lib/contract/trait-design.md) — Receiver, types, cohesion, dynamic dispatch, async.

### Practices

- [error-handling](lib/practices/error-handling.md) — Error type, variant naming, error chain.
- [testing](lib/practices/testing.md) — Three layers, test-only dependency philosophy.
- [naming](lib/practices/naming.md) — Crate naming by role.
- [feature-flag](lib/practices/feature-flag.md) — Capability presence, not behavioral variation.
- [observability](lib/practices/observability.md) — Zero logging, span instrumentation only.
- [no-std](lib/practices/no-std.md) — Three capability tiers, feature gate pattern.
- [documentation/general](lib/practices/documentation/general.md) — Universal comment/doc rules.
- [documentation/doc-comments](lib/practices/documentation/doc-comments.md) — Public item documentation, examples.
- [documentation/code-comments](lib/practices/documentation/code-comments.md) — When to comment, TODO/FIXME.

### Rust (lang/rust.md in each concept directory)

- [patterns/lang/rust](lib/patterns/lang/rust.md) — File layout, typestate, handle, lock strategy, spawn rules.
- [practices/lang/rust](lib/practices/lang/rust.md) — thiserror, Cargo.toml features, tracing, dev-dependencies.
- [documentation/lang/rust](lib/practices/documentation/lang/rust.md) — ///, clippy doc lints, SAFETY annotations.
- [contract/lang/rust](lib/contract/lang/rust.md) — Trait syntax, object safety, Send+Sync, async traits.

## Binary Crates

- [structure/layout](bin/structure/layout.md) — Two categories, file layout, scaling, naming.
- [structure/main-run](bin/structure/main-run.md) — Entry point, orchestration function, async runtime.
- [assembly](bin/assembly.md) — Manual DI, explicit params, no DI framework.
- [config](bin/config.md) — Priority, load() boundary, structural rules.
- [telemetry](bin/telemetry.md) — Two-step init, replaceable subscriber.
- [shutdown](bin/shutdown.md) — Graceful shutdown, cancellation, timeout.
- [error-handling](bin/error-handling.md) — Opaque error aggregation, no structured error types.
- [testing](bin/testing.md) — Orchestration tests, integration tests, real dependencies.

### Rust (lang/rust.md in each concept directory)

- [structure/lang/rust](bin/structure/lang/rust.md) — main.rs, run.rs, tokio, file naming.
- [lang/rust](bin/lang/rust.md) — anyhow, thiserror, Cargo config, tracing subscriber, test examples.
