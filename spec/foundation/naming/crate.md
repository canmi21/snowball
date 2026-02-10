# Naming — Crate

General naming conventions apply (see [common rules](common.md)).

## Hard Rules

- Never use `lib`, `util`, `helper`, or `common` as a suffix.
- The name describes what the crate is, not how to use it.

## By Crate Role

### Leaf Crate — Functional Naming

Name reflects the single transformation the crate performs.
Short, direct, noun-based.

```
retry               timeout             fs-notify
atomic-swap         hot-reload          config-parse
```

No ecosystem prefix — leaf crates are decoupled by design.
Check the language package registry for name availability
at development time; adjust as needed.

### Composition Crate — Domain Naming

Name reflects the problem domain the composition addresses.
Slightly more abstract than leaf names.

```
service-config      connection-manager      request-pipeline
```

### Convergence Crate — Depends on Context

**When the convergence represents a significant product or framework**
(a branded solution for a specific domain, similar to how `axum`
is a web framework):

Use brand naming — a unique, standalone name.

```
live                ← live-config-update framework
```

**When the convergence primarily wraps well-known external
ecosystem crates** (tokio, hyper, serde, etc.):

Use purpose-oriented naming that reflects the external dependencies.

```
config-reload-tokio     ← convergence around tokio for config reloading
web-stack-hyper         ← convergence around hyper for a web stack
```

## Trait Definition vs Implementation

Trait-definition crates and their implementations follow
a base-suffix pattern:

```
config-parse            → trait definition crate
config-parse-toml       → TOML implementation
config-parse-json       → JSON implementation
```

## Runtime Adaptation

When a crate provides runtime-specific adapters, append the runtime name:

```
hot-reload-tokio        → tokio adaptation
hot-reload-smol         → smol adaptation
```
