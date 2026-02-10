# Repository Model

## Structure

The ecosystem is split into two categories of repositories
based on a single criterion: **reusability**.

### Snowball Monorepo

One monorepo contains everything that is reusable across applications:

- All leaf crates (stateless and stateful).
- All composition crates (combinations at any abstraction level).
- All general-purpose convergence crates.
- The specification itself (`spec/`).
- Ecosystem documentation.

### Application Repos

Each binary application lives in its own dedicated repository:

- The binary crate (`main.rs`, `run.rs`, etc.).
- Application-specific orchestration crates that exist only for this binary.

### Separation Criterion

> Can this crate be reused by a different application?

- **Yes** → it belongs in the snowball monorepo.
- **No, it exists only for this application** → it belongs in the application repo.

## Inter-Crate Dependencies

Crates within the monorepo depend on each other through published versions
on the language package registry, **not** through local path references.

Each crate maintains its own independent version number following semver.

This discipline ensures:

- Any crate can be extracted to an independent repo at any time with zero disruption.
- Dependency relationships are explicit and auditable.
- No accidental coupling through workspace-level shared configuration.

## Application Repos Depend on the Monorepo

Application repos depend on snowball crates exclusively through
the language package registry. They never reference the monorepo by path.

For language-specific dependency configuration, see the relevant `lang/` spec.
