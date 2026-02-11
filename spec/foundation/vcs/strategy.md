# VCS Strategy

The snowball ecosystem uses [jj](https://jj-vcs.github.io/jj/) as its
version control system. Git serves as the storage backend via jj's
colocated mode and is never invoked directly.

## Colocated Model

Every repository is initialized with `jj git init --colocate`.
This creates both `.jj/` and `.git/` in the same directory.

- jj manages the working copy, commit graph, and all user operations.
- git stores objects and refs, enabling compatibility with GitHub,
  CI systems, and any tool that reads `.git/`.
- Direct git commands are prohibited in normal workflow.
  If a rare situation requires git (e.g., CI integration),
  document the reason in the commit body.

## Repository Topology

The ecosystem contains two kinds of repositories.

### Root Repository

A single jj repository at the monorepo root. It contains:

- `spec/` — the snowball specification.
- `library/` — all library crates (leaf, composition, convergence).
- Workspace configuration files (`Cargo.toml`, `qwq.toml`,
  `.editorconfig`, and similar).

### App Repositories

Each binary crate project lives under `app/` as an independent
jj repository. An app repository has its own `.jj/` and `.git/`,
its own commit history, and its own bookmarks.

## Nested Repository Isolation

App repositories are physically nested inside the monorepo directory
tree, but the two VCS histories are completely independent.

- The root `.gitignore` contains an entry for each app directory
  (e.g., `app/my-app/`). This prevents the root repository from
  tracking any files inside the app.
- No git submodules. The isolation relies solely on `.gitignore`.
- Each app repository is initialized independently with
  `jj git init --colocate` inside its own directory.

## Cargo Workspace

The root `Cargo.toml` defines a Cargo workspace that includes
`library/` members. Cargo resolves workspace membership by
filesystem path, independent of VCS boundaries.

App crates under `app/` are not root workspace members.
Each app defines its own independent `[workspace]` in its
`Cargo.toml`, with its own `[workspace.lints]`,
`[workspace.dependencies]`, and member list.
