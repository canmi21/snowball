# Key Decisions

## Architecture
- Crate roles are relative, not absolute (leaf/composition/convergence/binary)
- 300-line heuristic = thinking tool, not hard limit
- Dependency direction: stateless never depends on stateful
- Trait and implementation in separate crates by default
- Convergence crates: zero logic, only type aliases + constructors

## Directory Structure
- Library crate roles grouped under `library/`: `library/leaf/`, `library/composition/`, `library/convergence/`
- Language is implementation detail inside each crate, NOT a top-level directory
- App (bin) crates: physically nested in monorepo under `app/`, but independent jj repos
- App crates have own Cargo `[workspace]` (NOT members of root workspace)
- Root workspace: `members = []`, only library crates as members when added
- Config sharing: symlink `.editorconfig`; rustfmt config in `qwq.toml [fmt.rust]`; clippy config in `qwq.toml [lint.clippy]`; lint rules duplicated (Cargo limitation, qwq enforces consistency)
- Root `.gitignore`: `/app` + `/target`

## Project Memory (decided 2026-02-11)
- `.claude/rules/` — auto-loaded entry point (lightweight, always in system prompt)
- `.claude/memory/` — detailed knowledge base (read on demand, NOT auto-loaded)
- `.claude/rules/handover.md` — handover protocol (update memory → output context)
- Old `~/.claude/projects/.../memory/` cleared, replaced by in-repo files

## qwq CLI (decided 2026-02-11)
- First binary crate in snowball ecosystem
- Name `qwq` (snowball crate taken), project domain: monoflake.com/net
- Lives in `app/qwq/` as independent jj repo + Cargo workspace
- CLI tool category (not long-running service)
- Multi-level subcommand design from start
- Itself follows snowball philosophy (will split into lib crates as it grows)
- Dogfoods bin spec while developing, spec gaps discovered → evolve spec
- **Bootstrap period**: all code in qwq repo first, extract library crates later

## Error Handling
- Library: `thiserror`, structured Error enums, `#[non_exhaustive]`
- Binary: `anyhow` exclusively, no Error enums, `.context()` for chain
- Never mix: libraries never use anyhow, binaries never define Error enums

## Panic Policy
- No intentional panic code (unwrap/expect/panic!/todo! all forbidden)
- Panic exists as invisible safety net for bugs
- Binary startup boundary: before run() = Result preferred, after run() = panic forbidden

## VCS: jj Primary + git Backend (spec landed 2026-02-10)
- **jj is sole user-facing VCS**, git is invisible backend (colocated mode)
- Spec location: `spec/foundation/vcs/` (8 files)
- Commit format: `type(scope): description` (≤72 chars, 11 types)
- Bookmark naming: `scope/description` (task-level, not crate-level)
- Nested repos: outer .gitignore ignores inner dirs, no submodules
- Symlinks: define once at root, symlink into crates, cargo publish resolves
- Commit wrapper: `qwq vcs commit` (supports split mode)
- All commits must go through wrapper — agents prohibited from calling jj/git directly

## Multi-Language Abstraction (completed 2026-02-10)
- Universal philosophy + `lang/rust.md` per concept leaf directory
- Pattern: `concept-dir/lang/rust.md` (NOT `lang/rs/concept-dir/`)
- Target languages: Rust (core), C, Go, TS (full), Python (partial)

## Spec Versioning
- Spec uses UTC timestamp, NOT semver: `date -u +"%Y-%m-%dT%H:%M:%SZ"`
- Stored in `spec/VERSION`
- Each crate tracks which spec version it follows
- Code crates keep semver

## Spec Evolution
- Self-hosting declared, bootstrap archived (then deleted, history in git)
- Fast path: additive/corrective changes, lightweight
- Full path: breaking changes, migration guide required
- LLM compliance: immediately follow new rules after spec update
- Pragmatic during spec modification, strict after

## Compliance
- Layer 1: `qwq check` (6 mechanical checks, CI gate)
- Layer 2: spec-review agent (semantic checks, dynamic spec reading, can propose evolution)

## CHANGELOG
- 5 categories: Added, Fixed, Changed, Removed, Breaking
- Order in entry: Breaking first, then Added, Changed, Fixed, Removed
- Library/binary 1.0+: only Added and Fixed
- Spec: all 5 always permitted, timestamp as version
- No comparison links (monorepo)

## Testing
- 3 layers: happy path, error path, fuzz
- Dev-dependencies: aggressively leverage standard implementations
- Binary: real dependencies over mocks (testcontainers)
- Binary tests call run() directly, not the binary process
