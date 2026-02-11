# Changelog

All notable changes to the snowball specification
will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
adapted for the [snowball ecosystem](foundation/changelog/format.md).
Spec revisions use UTC timestamps as version identifiers.

## [2026-02-11T05:29:40Z]

### Changed

- Compliance specification updated: Layer 1 migrated from shell scripts to
  `qwq` CLI as primary mechanical check provider. Added `qwq check` command
  documentation and updated commit message enforcement reference from
  `tools/vcs/commit.sh` to `qwq vcs commit`. Clarified check modification
  as breaking signal.
  Files: `foundation/compliance.md`.

- Directory structure specification updated: workspace root configuration
  replaced Makefile with `qwq.toml` as the canonical entry point. Updated
  description to reflect `qwq` CLI as the workspace-level operations entry
  point for formatting, compliance checks, and VCS workflow.
  Files: `foundation/architecture/directory.md`.

- Commit message specification refined: "jj Workflow" section replaced with
  "Commit Workflow" section documenting `qwq vcs commit` as the unified
  commit interface. Added split-file workflow documentation with `-- files`
  syntax. Removed direct jj commands from normal workflow; clarified that
  `qwq` tool ensures message compliance.
  Files: `foundation/vcs/commit-message.md`.

## [2026-02-10T17:18:58Z]

### Changed

- VCS strategy specification enhanced with "App Repositories" section clarifying
  independent jj repository model for binary crate projects under `app/`.
  Documented nested repository isolation, `.gitignore` enforcement, and VCS boundary
  separation from root repository.
  Files: `foundation/vcs/strategy.md`.

- Shared configuration specification expanded with "App Configuration" section
  documenting tool access patterns across Cargo workspace boundaries. Defined
  symlink rules for rustfmt/editorconfig and duplication requirement for
  `[workspace.lints]` in app Cargo.toml. Noted qwq enforcement of lint consistency.
  Files: `foundation/vcs/shared-config.md`.

- Directory structure specification updated: added `app/` directory to monorepo
  layout tree showing independent jj/git isolation. Clarified binary crate
  description: physically nested but separate VCS history and Cargo workspace.
  Files: `foundation/architecture/directory.md`.

## [2026-02-10T16:16:38Z]

### Added

- vcs-land agent registered in agent inventory. Purpose: fast-forward main bookmark
  to the latest commit after task completion. Uses haiku model without memory.
  Files: `foundation/agent/registry.md`, `.claude/agents/vcs-land.md`.

### Changed

- Foundation VCS specification migrated from git-centric to VCS-agnostic model.
  Renamed foundation/git/ directory to foundation/vcs/ and rewrote all 8 files for
  jj-colocated workflow: strategy.md (repository topology, nested isolation),
  shared-config.md (symlink rules, workspace inheritance), commit-message.md (11 types,
  jj workflow section), commit-scope.md (granularity rules), bookmarks.md (task-level
  bookmarks, jj syntax), lib.md/bin.md/spec.md (domain rules with jj guidance).
  Cross-references updated: CLAUDE.md, spec/README.md, directory.md, compliance.md,
  contribution.md, process.md, changelog/spec.md, tools/check/links.sh, allowlist.toml.
  Files: `foundation/vcs/strategy.md`, `foundation/vcs/shared-config.md`,
  `foundation/vcs/commit-message.md`, `foundation/vcs/commit-scope.md`,
  `foundation/vcs/bookmarks.md`, `foundation/vcs/lib.md`, `foundation/vcs/bin.md`,
  `foundation/vcs/spec.md`.

- Commit wrapper migration: tools/git/commit.sh (git-native) replaced with
  tools/vcs/commit.sh (jj-native). Updated in compliance.md and spec-commit agent.
  Files: `tools/vcs/commit.sh`, `foundation/compliance.md`.

### Removed

- spec/archived/ directory deleted (bootstrap.md, bootstrap-checklist.md).
  Git history preserves content for historical reference.

## [2026-02-10T14:03:07Z]

### Changed

- Foundation specs generalized for multi-language support: extracted Rust-specific rules
  to `foundation/*/lang/rust.md` files. Modified: type-flow.md (generalized to patterns),
  panic-policy.md (replaced thiserror/anyhow with structured/opaque), dependency.md
  (removed Rust version/registry details), publication/contribution.md, evolution/triggers.md,
  safety/_, naming/crate.md, git/commit-scope.md, architecture/_ directory references,
  compliance.md, lifecycle.md.
  Files: `foundation/architecture/type-flow.md`, `foundation/architecture/lang/rust.md`,
  `foundation/architecture/directory.md`, `foundation/architecture/repository.md`,
  `foundation/panic-policy.md`, `foundation/safety/panic-policy.md`,
  `foundation/safety/lang/rust.md`, `foundation/safety/dependency.md`,
  `foundation/evolution/triggers.md`, `foundation/evolution/lang/rust.md`,
  `foundation/lifecycle.md`, `foundation/naming/crate.md`, `foundation/naming/lang/rust.md`,
  `foundation/git/commit-scope.md`, `foundation/git/lang/rust.md`,
  `foundation/publication/contribution.md`, `foundation/publication/lang/rust.md`,
  `foundation/compliance.md`.

- Library specs generalized for multi-language support: extracted Rust-specific rules
  to `lib/*/lang/rust.md` files. Pattern files refactored to remove code examples while
  preserving structure rules. Practices documentation split: doc-comments, code-comments
  now language-agnostic with Rust details in documentation/lang/rust.md.
  Files: `lib/patterns/stateless-sync.md`, `lib/patterns/stateless-async.md`,
  `lib/patterns/stateful-sync.md`, `lib/patterns/stateful-async.md`,
  `lib/patterns/lang/rust.md`, `lib/contract/trait-design.md`, `lib/contract/lang/rust.md`,
  `lib/practices/error-handling.md`, `lib/practices/testing.md`,
  `lib/practices/feature-flag.md`, `lib/practices/observability.md`,
  `lib/practices/documentation/doc-comments.md`, `lib/practices/documentation/code-comments.md`,
  `lib/practices/documentation/lang/rust.md`, `lib/practices/lang/rust.md`.

- Binary specs generalized for multi-language support: replaced Rust-specific syntax
  with universal abstractions. Extracted Rust examples (main.rs, run.rs, tokio, anyhow)
  to `bin/lang/rust.md` and `bin/structure/lang/rust.md`. Modified: assembly.md
  (main/run → entry/orchestration), config.md (struct examples → universal rules),
  error-handling.md (anyhow/thiserror → opaque/structured), structure/layout.md
  (.rs extensions → universal names), structure/main-run.md (generalized entry/orchestration),
  telemetry.md (tracing → universal pattern), testing.md (tokio → universal rules).
  Fixed shutdown.md reference (item 24 → SFA-6).
  Files: `bin/assembly.md`, `bin/config.md`, `bin/error-handling.md`,
  `bin/lang/rust.md`, `bin/shutdown.md`, `bin/structure/layout.md`,
  `bin/structure/lang/rust.md`, `bin/structure/main-run.md`, `bin/telemetry.md`,
  `bin/testing.md`.

## [2026-02-10T11:36:52Z]

### Added

- Composition Crate pass-through features section to guide feature propagation
  across composition layers. Files: `lib/practices/feature-flag.md`.

### Changed

- Rust file naming: removed contradiction between layout.md and role examples,
  established file-structure.md as single source for file naming.
  Files: `bin/structure/layout.md`.

- Roles specification: removed 300-line heuristic duplication, replaced with
  SCoL references linking to foundation/heuristics.md as single source.
  Files: `foundation/architecture/roles.md`.

- Directory layout: added `.claude/agents/` and `tools/` subdirectories to
  monorepo structure, clarifying workspace organization beyond main crate roles.
  Files: `foundation/architecture/directory.md`.

- Compliance enforcement moved from Layer 1 check list to commit-time enforcement
  description, documenting the sequential order of verification stages.
  Files: `foundation/compliance.md`.

- Library pattern checklists standardized with explicit prefixes: stateless-sync (SS),
  stateless-async (SA), stateful-sync (SFS), stateful-async (SFA). Removed 300-line
  hardcoding in favor of heuristic reference.
  Files: `lib/patterns/stateless-sync.md`, `lib/patterns/stateless-async.md`,
  `lib/patterns/stateful-sync.md`, `lib/patterns/stateful-async.md`.

### Fixed

- Unreleased section exemption: specification CHANGELOG explicitly documents that
  spec modifications produce immediate timestamps with no unreleased state.
  Files: `foundation/changelog/spec.md`.

- Stateful-async pattern: explicit inheritance rules for composition and feature
  interaction with exclusion notes for incompatible combinations.
  Files: `lib/patterns/stateful-async.md`.

## [2026-02-10T10:32:33Z]

### Changed

- Allowlist section expanded with explicit re-evaluation guidance:
  when hash mismatches, determine if content now has multiple concerns
  (split) or remains cohesive (update hash).
  Files: `foundation/heuristics.md`.

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
  Files: `archived/bootstrap.md` (formerly `foundation/evolution/bootstrap.md`),
  `foundation/git/commit-scope.md`.

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
  Files: `archived/bootstrap.md` (formerly `foundation/evolution/bootstrap.md`),
  `foundation/evolution/triggers.md`,
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
