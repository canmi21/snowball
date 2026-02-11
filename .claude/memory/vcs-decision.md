# VCS Decision: jj as Primary, git as Backend

## Decision (confirmed by user)
- **jj** is the sole user-facing VCS — all commands use jj
- **git** is an invisible backend, auto-managed by jj colocated mode
- Direct git commands prohibited (CI exceptions must be documented)

## Spec Landing (COMPLETED 2026-02-10)

### Files created in `spec/foundation/vcs/`:
1. `strategy.md` — jj colocated model, repo topology, nested isolation
2. `shared-config.md` — symlink rules, workspace config inheritance table
3. `commit-message.md` — 11 types, format, scope + jj workflow section
4. `commit-scope.md` — granularity rules, workspace config rule generalized
5. `bookmarks.md` — task-level bookmarks, scope/description naming
6. `lib.md` — library crate VCS rules
7. `bin.md` — binary crate VCS rules
8. `spec.md` — spec VCS rules

## Bookmark Strategy
- Task-level bookmarks: `scope/description` (not per-crate)
- Scope = primary driver: crate name, app name, `spec`, or logical theme
- Trivial changes go direct to main
- Spec changes during a task stay in the task's bookmark
- Cross-repo tasks use same bookmark name in all involved repos
- Parallel tasks: multiple bookmarks coexist, rebase to sequence

## Verified: Nested jj+git Repos Work (tested 2026-02-10)

1. Outer jj+git repo with `.gitignore` ignoring `inner-app/`
2. Inner `jj git init --colocate` creates independent `.jj/` + `.git/`
3. Both repos have completely independent histories
4. Symlinks from inner → outer work, `cargo publish` follows symlinks
5. **Conclusion: No submodules needed. Pure .gitignore isolation.**

## Repository Topology
- Root jj repo: spec/ + library/ + workspace config
- App (bin) crates: independent jj repos under app/, root ignores them
- Cargo workspace includes library/ members, NOT app/ crates

## Workspace "Define Once" Capability
| Config | Mechanism | Needs symlink? |
|--------|-----------|---------------|
| Rust lints | `[workspace.lints]` | No |
| Dep versions | `[workspace.dependencies]` | No |
| rustfmt | `qwq.toml [fmt.rust]`, passed via `--config` CLI args | No |
| clippy | `qwq.toml [lint.clippy]`, temp file at runtime | No |
| editorconfig | Root `.editorconfig` | No |
| LICENSE | Symlink → root | Yes |
| Cross-language config | Symlink → root | Yes |
