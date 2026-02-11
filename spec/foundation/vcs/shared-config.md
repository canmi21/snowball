# Shared Configuration

Configuration files are defined once at the repository root
and shared across crates through inheritance or symlinks.

## Define Once

Every configuration value has a single source of truth at the
workspace root. Crates must not duplicate or override workspace-level
settings unless the spec explicitly permits it.

## Inheritance Table

Some tools walk up the directory tree and find root configuration
automatically. Others require an explicit symlink.

| Config          | Mechanism                               | Symlink needed |
| --------------- | --------------------------------------- | -------------- |
| Lints           | `[workspace.lints]` in Cargo.toml       | No             |
| Dep versions    | `[workspace.dependencies]`              | No             |
| rustfmt         | `qwq.toml` `[fmt.rust]`, passed via CLI | No             |
| clippy          | `clippy.toml` at root, tool walks up    | No             |
| editorconfig    | `.editorconfig` at root, tool walks up  | No             |
| LICENSE         | Symlink to root file                    | Yes            |
| Language config | Symlink to root file                    | Yes            |

App repositories under `app/` do not inherit from the root
workspace automatically. Each app manages its configuration
through a combination of symlinks and local definitions.

### App Configuration

Tool configuration files that support directory walk-up in the
root workspace do not walk up from an independent app repository.
Apps must establish their own access to shared configuration.

| Config       | App mechanism                         |
| ------------ | ------------------------------------- |
| rustfmt      | Via `qwq fmt` (reads `qwq.toml`)      |
| editorconfig | Symlink `.editorconfig` to root       |
| Lints        | Duplicate `[workspace.lints]` locally |
| LICENSE      | Symlink to root file                  |

Lint rules (`[workspace.lints.clippy]`) cannot inherit across
Cargo workspace boundaries. Each app must define its own
`[workspace.lints]` section matching the root configuration.
The `qwq` tool enforces consistency by detecting drift between
app and root lint definitions.

## Symlink Rules

- Use relative paths. A symlink inside a crate points upward
  to the root file (e.g., `../../LICENSE`).
- The symlink name must match the target file name.
  `LICENSE -> ../../LICENSE`, not `license-link -> ../../LICENSE`.
- Create a symlink only when the tool does not support directory
  walk-up or workspace inheritance. Prefer native inheritance
  mechanisms over symlinks.

## Publishing Behavior

`cargo publish` resolves symlinks to their actual content.
The published `.crate` tarball contains the real file, not the
symlink. This means symlinked LICENSE files appear correctly
in the published package.

jj and git both track symlinks as path strings. Cloning a
repository recreates the symlinks, which resolve correctly
as long as the target exists at the expected relative path.
