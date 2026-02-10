# Branching

## Long-Lived Branches

`main` is the only long-lived branch.
It is always in a releasable state.

No `develop`, `release`, or `hotfix` branches.
The snowball ecosystem follows trunk-based development.

## Work Branches

Create a short-lived branch for any change that involves
business code or spec modifications.

### Naming

```
type/scope/short-description
```

- `type` — one of the eleven commit types (see [commit-message](commit-message.md)).
- `scope` — crate name, spec area, or `workspace`.
- `short-description` — lowercase, hyphens, brief.

Examples: `add/my-crate/parser`, `fix/my-crate/empty-input`, `spec/foundation/git-rules`.

### Lifecycle

1. Branch from `main`.
2. Develop, commit following [commit-message](commit-message.md) rules.
3. Clean up history before merging (see below).
4. Fast-forward merge into `main`.
5. Delete the branch.

## Direct Push to Main

Trivial changes that do not touch business code or spec
may be pushed directly to `main` without a branch:

- Typo fixes.
- `chore` and `ci` type changes.
- Minor `doc` updates.

## History Cleanup

During development, quick-fix commits (fixing a mistake from an earlier commit
in the same branch) are natural. Before merging, clean them up.

### Recommended Workflow

Use `fixup!` commits during development:

```bash
git commit --fixup=<target-commit-hash>
```

When ready to merge, auto-squash without an interactive editor:

```bash
GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash main
```

This merges each `fixup!` commit into its target,
leaving only meaningful commits in the final history.

## Merge Strategy

Fast-forward merge only:

```bash
git checkout main
git merge --ff-only <branch>
```

No merge commits. The commit history on `main` is linear.

Every commit on `main` must independently satisfy
the [commit-message](commit-message.md) and [commit-scope](commit-scope.md) rules.

## Tags

Each crate is versioned and tagged independently:

```
crate-name/v0.1.0
```

Tags follow [versioning](../publication/versioning.md) rules.
Tag only after the crate passes the full [publication checklist](../publication/checklist.md).
