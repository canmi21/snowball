# Commit Scope

Granularity rules for commits in the snowball monorepo.

## Core Principle

One commit = one crate, one logical change.

## Rules

1. **Single crate per commit.**
   A commit must not touch more than one crate.
   Cross-crate changes are split into separate commits
   (see [commit-message](commit-message.md) cross-crate rule).

2. **Single purpose per commit.**
   One bug fix, one feature, or one refactor — not a mix.
   Do not combine unrelated changes in a single commit.

3. **Do not over-split.**
   When a single logical change spans multiple files within the same crate
   (interface + implementation + tests), keep them in one commit.
   Splitting artificially leaves the repository in a broken intermediate state.

4. **Spec and code are separate commits.**
   A spec change and its corresponding code change are two commits,
   even if they arise from the same task.

## Exceptions

- **`break` commits** may include migration documentation
  alongside the breaking change itself.
- **`chore(workspace)` commits** may touch workspace-level files
  that inherently span multiple crates
  (e.g., workspace `Cargo.toml` dependency version updates).
