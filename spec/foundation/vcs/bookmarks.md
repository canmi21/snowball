# Bookmarks

## Long-Lived Bookmarks

`main` is the only long-lived bookmark.
It is always in a releasable state.

No `develop`, `release`, or `hotfix` bookmarks.
The snowball ecosystem follows trunk-based development.

## Task Bookmarks

Create a short-lived bookmark for any non-trivial task.
A task bookmark groups all commits that serve a single logical goal,
regardless of commit type. A bookmark may contain `spec`, `add`, `fix`,
`refactor`, and other commit types — what matters is that they all
belong to the same task.

### Naming

```
scope/description
```

- `scope` — the primary driver or area of the task.
- `description` — lowercase, hyphens, brief.

| Scenario                  | Example                       |
| ------------------------- | ----------------------------- |
| Single crate work         | `my-crate/add-parser`         |
| Multi-crate initiative    | `error-handling/unify-types`  |
| App-driven library work   | `my-app/auth-support`         |
| Standalone spec work      | `spec/vcs-migration`          |

Spec changes that arise during a development task stay in the
current task bookmark. Use `spec/` scope only for standalone
spec work with no associated implementation.

When a task spans multiple repositories (root and app repos),
use the same bookmark name in every involved repository.

### Lifecycle

1. Create a new change from main: `jj new main`.
2. Create the bookmark: `jj bookmark create scope/description`.
3. Develop. Each commit follows [commit-message](commit-message.md)
   and [commit-scope](commit-scope.md) rules.
4. Clean up history (see below).
5. Fast-forward `main` to the bookmark tip.
6. Delete the bookmark: `jj bookmark delete scope/description`.

## Direct Commit to Main

Trivial changes that do not require a task bookmark
may be committed directly on `main`:

- Typo fixes.
- `chore` and `ci` type changes.
- Minor `doc` updates.
- Small workspace-level tooling adjustments.

## History Cleanup

During development, quick-fix commits are natural.
Before merging into `main`, squash them into their logical parent.

```
jj squash
```

This folds the current change into its parent.
Use `jj squash --into <target>` to fold into a specific ancestor.

The goal is the same as the old fixup workflow: every commit
on `main` must independently satisfy the
[commit-message](commit-message.md) and [commit-scope](commit-scope.md) rules.

## Merge Strategy

Fast-forward only. The commit history on `main` is linear.

When a task bookmark has fallen behind `main`, rebase first:

```
jj rebase -b scope/description -d main
```

Then advance `main` to the bookmark tip:

```
jj bookmark set main -r scope/description
```

No merge commits.

## Parallel Tasks

Multiple task bookmarks can coexist in the same repository.
Each bookmark branches from `main` independently.

When two bookmarks are ready to merge:

1. Fast-forward `main` to the first bookmark.
2. Rebase the second bookmark onto the new `main`.
3. Fast-forward `main` to the second bookmark.

As long as the bookmarks modify different files,
the rebase resolves cleanly.

If both bookmarks need to modify the same library crate,
coordinate the changes: complete one task first,
merge it into `main`, then rebase the other.

## Tags

Each crate is versioned and tagged independently:

```
crate-name/v0.1.0
```

Tags follow [versioning](../publication/versioning.md) rules.
Tag only after the crate passes the full
[publication checklist](../publication/checklist.md).
