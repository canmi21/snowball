# Dependency Safety

## Minimal Dependency Principle

Every dependency increases the attack surface and maintenance burden.
A crate should depend on as few external crates as possible.

Before adding a dependency, apply the trusted foundation crate evaluation
(see [trait-design](../../lib/contract/trait-design.md) Third-Party Type Isolation):

1. Does a crate exist that solves this problem?
2. Are its boundaries clear?
3. Does its design align with the ecosystem philosophy?
4. Decision: trusted (use directly), semi-trusted (wrap), or rewrite.

## Vulnerability Auditing

Run `cargo audit` regularly to check for known vulnerabilities
in the dependency tree.

- `cargo audit` must pass with zero known vulnerabilities
  before any crate is published.
- When a vulnerability is reported in a dependency:
  update the dependency if a fix exists,
  or replace it if the maintainer is unresponsive.

## Dependency Review for Updates

When updating a dependency version:

- Review the changelog for unexpected changes.
- Prefer exact or tightly bounded version ranges
  to avoid pulling in unreviewed code automatically.
- Treat a major version bump in a dependency as a signal
  to re-evaluate whether the dependency is still appropriate.
