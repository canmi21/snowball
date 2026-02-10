# Naming — Rust

Rust-specific practices for the [naming](../) specifications.

## Package Registry

Check [crates.io](https://crates.io) availability at development time.

## Runtime Adaptation

When a crate provides runtime-specific adapters, append the runtime name:

```
hot-reload-tokio        → tokio adaptation
hot-reload-smol         → smol adaptation
```
