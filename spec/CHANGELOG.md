# Changelog

All notable changes to the snowball specification
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
adapted for the [snowball ecosystem](foundation/changelog/format.md).
Spec revisions use UTC timestamps as version identifiers.

## [2026-02-10T09:16:25Z]

### Added

- Agent registry table with 4 agents: `spec-cascade`, `spec-check`, `spec-commit`,
  `spec-review`. Agent files in `.claude/agents/` with required frontmatter.
  Files: `foundation/agent/registry.md`.

- Agent creation process: interactive choices for purpose, model, memory, tools.
  Files: `foundation/agent/creation.md`.

- Agent first rule: stop on spec gap, never improvise, user retains decision authority.
  Files: `foundation/agent/first-rule.md`.

- Agent directory structure splitting single file into specialized topics.
  Files: `foundation/agent/overview.md`, `foundation/agent/creation.md`,
  `foundation/agent/first-rule.md`, `foundation/agent/model-selection.md`,
  `foundation/agent/registry.md`.

### Changed

- Agent specification refactored from single file into directory with specialized topics.
  Files: `foundation/agent/overview.md` (formerly `foundation/agent.md`).

## [2026-02-10T09:01:13Z]

### Added

- Agent specification: sub-agent definition, frontmatter, model selection,
  memory rules.
  Files: `foundation/agent.md`.

## [2026-02-10T08:39:43Z]

### Added

- Makefile documented as global task entry point in workspace root.
  Files: `foundation/architecture/directory.md`.

- Compliance script location links to Makefile entry point.
  Files: `foundation/compliance.md`.

## [2026-02-10T08:23:24Z]

### Changed

- Bootstrap phase rules clarified: self-hosting declaration is separate from
  spec version release. Relaxed cross-area commit splitting during bootstrap.
  Files: `foundation/evolution/bootstrap.md`, `foundation/git/commit-scope.md`.

## [2026-02-09T23:47:39Z]

### Added

- Timestamp versioning for spec, separate from code crate semver.
  Files: `foundation/publication/versioning.md`, `spec/VERSION`, `spec/CHANGELOG.md`,
  `foundation/changelog/spec.md`.

- Heuristics specification: thresholds for 100-line split, 300 SCoL per crate,
  4-level max depth.
  Files: `foundation/heuristics.md`.

### Changed

- Architecture directory references: dependency, type-flow, repository patterns.
  Files: `foundation/architecture/dependencies.md`, `foundation/architecture/type-flow.md`,
  `foundation/architecture/repository.md`.

## [2026-02-07T16:49:16Z]

### Added

- Complete foundation specification with 4 major spec sections:
  architecture, lifecycle, writing style, naming, compliance.
  Files: `foundation/architecture/` (7 files), `foundation/lifecycle.md`,
  `foundation/writing-style.md`, `foundation/naming/` (3 files), `foundation/compliance.md`.

- Complete library crate specification: patterns, contract, practices.
  Files: `lib/patterns/` (4 files), `lib/contract/trait-design.md`,
  `lib/practices/` (9 files).

- Complete binary crate specification: structure, assembly, config, telemetry,
  shutdown, error handling, testing.
  Files: `bin/` (8 files).

- Publication specification: checklist, versioning, contribution rules.
  Files: `foundation/publication/` (3 files).

- Safety specification: panic policy, unsafe code, dependency review.
  Files: `foundation/safety/panic-policy.md`, `foundation/safety/unsafe-code.md`,
  `foundation/safety/dependency.md`.

- Evolution specification: bootstrap phase, triggers, types, process, impact.
  Files: `foundation/evolution/bootstrap.md`, `foundation/evolution/triggers.md`,
  `foundation/evolution/types.md`, `foundation/evolution/process.md`,
  `foundation/evolution/impact.md`.

- CHANGELOG specification: format, library crate, binary crate, spec rules.
  Files: `foundation/changelog/format.md`, `foundation/changelog/lib.md`,
  `foundation/changelog/bin.md`, `foundation/changelog/spec.md`.

- Git specification: commit message, commit scope, branching, per-area rules.
  Files: `foundation/git/commit-message.md`, `foundation/git/commit-scope.md`,
  `foundation/git/branching.md`, `foundation/git/lib.md`, `foundation/git/bin.md`,
  `foundation/git/spec.md`.

- Library crate patterns: stateless-sync, stateless-async, stateful-sync,
  stateful-async.
  Files: `lib/patterns/stateless-sync.md`, `lib/patterns/stateless-async.md`,
  `lib/patterns/stateful-sync.md`, `lib/patterns/stateful-async.md`.

- Library crate contract: trait design.
  Files: `lib/contract/trait-design.md`.

- Library crate practices: error handling, testing, naming, feature flags,
  observability, no-std, documentation.
  Files: `lib/practices/error-handling.md`, `lib/practices/testing.md`,
  `lib/practices/naming.md`, `lib/practices/feature-flag.md`,
  `lib/practices/observability.md`, `lib/practices/no-std.md`,
  `lib/practices/documentation/general.md`, `lib/practices/documentation/doc-comments.md`,
  `lib/practices/documentation/code-comments.md`.

- Binary crate specification: structure, main-run pattern, assembly, config,
  telemetry, shutdown, error handling, testing.
  Files: `bin/structure/layout.md`, `bin/structure/main-run.md`, `bin/assembly.md`,
  `bin/config.md`, `bin/telemetry.md`, `bin/shutdown.md`, `bin/error-handling.md`,
  `bin/testing.md`.

- Spec meta: version tracking, specification index, LLM entry point.
  Files: `spec/VERSION`, `spec/README.md`, root `CLAUDE.md`.

### Fixed

- Convergence rules duplicated between `roles.md` and `convergence.md`.
  Files: `foundation/architecture/convergence.md`, `foundation/architecture/roles.md`.

- Writing style gaps in LLM compliance and terminology.
  Files: `foundation/writing-style.md`.

- Minor corrections to observability and no-std specifications.
  Files: `lib/practices/observability.md`, `lib/practices/no-std.md`.
