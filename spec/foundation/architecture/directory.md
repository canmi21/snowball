# Directory Structure

## Principle

The monorepo directory structure mirrors snowball's conceptual hierarchy.
Top-level directories correspond to crate roles, not languages.
Language is an implementation detail inside each crate.

## Monorepo Layout

```
monorepo/
├── spec/                   ← specification
│   ├── VERSION
│   ├── README.md
│   ├── foundation/
│   ├── lib/
│   └── bin/
├── library/                ← all library crates
│   ├── leaf/               ← leaf crates
│   │   ├── retry/
│   │   ├── config-parse/
│   │   └── config-parse-toml/
│   ├── composition/        ← composition crates
│   │   └── service-config/
│   └── convergence/        ← convergence crates
│       └── config-reload-tokio/
├── app/                    ← binary crate projects (independent repos)
│   └── qwq/               ← each app has own .jj/, .git/, [workspace]
├── tools/                  ← workspace tooling
│   ├── check/              ← compliance scripts
│   └── vcs/                ← VCS operation wrappers
├── .claude/
│   └── agents/             ← LLM sub-agent definitions
├── Cargo.toml              ← workspace root
├── CLAUDE.md
└── README.md
```

## Layer Directories

| Directory              | Contains                               | Crate Role                    |
| ---------------------- | -------------------------------------- | ----------------------------- |
| `library/leaf/`        | Crates with no snowball dependencies   | Leaf (stateless and stateful) |
| `library/composition/` | Crates that combine lower-level crates | Composition                   |
| `library/convergence/` | Crates that pin generics, zero logic   | Convergence                   |

Binary crates live under `app/` as independent VCS repositories.
They are physically inside the monorepo directory tree but maintain
their own `.jj/`, `.git/`, and Cargo `[workspace]`
(see [VCS strategy](../vcs/strategy.md)).

## Inside Each Crate

Each crate directory follows its language's native structure:

- **Rust**: `Cargo.toml`, `src/`, `tests/`
- **TypeScript**: `package.json`, `src/`, `tests/`
- **Go**: `go.mod`, `*.go`, `*_test.go`

Crate naming follows [naming](../naming/crate.md) conventions.
The directory name matches the crate name.

## Multi-Language

The same conceptual slot may have implementations in multiple languages.
Language-specific variants use a suffix:

```
library/leaf/
├── config-parse/           ← Rust trait definition
├── config-parse-toml/      ← Rust implementation
└── config-parse-ts/        ← TypeScript implementation
```

The hierarchy is: **layer → implementation → language internals**.
Language never appears as a top-level directory.

## Workspace Root

Shared configuration that applies to all crates of a language
lives at the monorepo root:

- `Makefile` — Global task entry point: check, fmt, and other operations.
- `.editorconfig` — Editor indentation and whitespace rules.
- Language-specific workspace and tooling configuration.

This avoids duplicating configuration in every crate.
`Makefile` serves as the single entry point for all workspace-level
operations, delegating to scripts in `tools/` and language-specific
tooling as needed.

For language-specific root configuration files, see the relevant `lang/` spec.

## Crate Promotion

When a crate's role changes (e.g., a leaf crate becomes a composition crate
because it gains a snowball dependency), move it to the correct
layer directory. Update the workspace configuration accordingly.
