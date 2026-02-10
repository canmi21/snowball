# Changelog

All notable changes to the snowball specification
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
adapted for the [snowball ecosystem](foundation/changelog/format.md).
Spec revisions use UTC timestamps as version identifiers.

## [2026-02-10T07:50:05Z]

### Added

- Naming specification promoted to foundation level: common rules,
  file structure, and crate naming.
  Files: `foundation/naming/common.md`, `file-structure.md`, `crate.md`.

- Heuristics specification: threshold philosophy, evaluation method,
  allowlist mechanism for mechanical checks.
  Files: `foundation/heuristics.md`.

### Changed

- Naming in library practices simplified to links to foundation.
  Files: `lib/practices/naming.md`.

- Writing style: file size and nesting depth now link to heuristics.
  Files: `foundation/writing-style.md`.

- Crate roles: 300-line heuristic section links to heuristics.
  Files: `foundation/architecture/roles.md`.

- CLAUDE.md: replaced 300-line heuristic concept with broader
  heuristics entry.
  Files: root `CLAUDE.md`.

## [2026-02-10T06:11:23Z]

### Added

- Architecture specification: crate roles, convergence rules, dependency
  direction, repository separation, trait-impl separation, type flow,
  directory structure.
  Files: `foundation/architecture/roles.md`, `convergence.md`,
  `dependencies.md`, `repository.md`, `trait-impl-separation.md`,
  `type-flow.md`, `directory.md`.

- Lifecycle specification: three phases.
  Files: `foundation/lifecycle.md`.

- Writing style specification: language, tone, structure, LLM compliance.
  Files: `foundation/writing-style.md`.

- Compliance specification: two-layer checking (shell scripts + LLM agent).
  Files: `foundation/compliance.md`.

- Publication specification: pre-publish checklist, semver rules, contribution.
  Files: `foundation/publication/checklist.md`, `versioning.md`,
  `contribution.md`.

- Safety specification: panic policy, unsafe code, dependency review.
  Files: `foundation/safety/panic-policy.md`, `unsafe-code.md`,
  `dependency.md`.

- Evolution specification: bootstrap phase, triggers, types, process, impact.
  Files: `foundation/evolution/bootstrap.md`, `triggers.md`, `types.md`,
  `process.md`, `impact.md`.

- CHANGELOG specification: format, library crate, binary crate, spec rules.
  Files: `foundation/changelog/format.md`, `lib.md`, `bin.md`, `spec.md`.

- Git specification: commit message, commit scope, branching, per-area rules.
  Files: `foundation/git/commit-message.md`, `commit-scope.md`,
  `branching.md`, `lib.md`, `bin.md`, `spec.md`.

- Library crate patterns: stateless-sync, stateless-async, stateful-sync,
  stateful-async.
  Files: `lib/patterns/stateless-sync.md`, `stateless-async.md`,
  `stateful-sync.md`, `stateful-async.md`.

- Library crate contract: trait design.
  Files: `lib/contract/trait-design.md`.

- Library crate practices: error handling, testing, naming, feature flags,
  observability, no-std, documentation.
  Files: `lib/practices/error-handling.md`, `testing.md`, `naming.md`,
  `feature-flag.md`, `observability.md`, `no-std.md`,
  `documentation/general.md`, `doc-comments.md`, `code-comments.md`.

- Binary crate specification: structure, main-run pattern, assembly, config,
  telemetry, shutdown, error handling, testing.
  Files: `bin/structure/layout.md`, `main-run.md`, `assembly.md`,
  `config.md`, `telemetry.md`, `shutdown.md`, `error-handling.md`,
  `testing.md`.

- Spec meta: version tracking, specification index, LLM entry point.
  Files: `VERSION`, `README.md`, root `CLAUDE.md`.

### Fixed

- Convergence rules duplicated between `roles.md` and `convergence.md`.
  Files: `foundation/architecture/convergence.md`, `roles.md`.

- Writing style gaps in LLM compliance and terminology.
  Files: `foundation/writing-style.md`.

- Minor corrections to observability and no-std specifications.
  Files: `lib/practices/observability.md`, `no-std.md`.
