# Dependency Assembly

## Principle

Manual assembly. The type system is the dependency injection container.

All dependencies are constructed by hand in `run()` and passed explicitly.
No DI framework. A missing dependency is a compile error.

## Assembly Site

Only in the `run()` function. main.rs does not construct dependencies.

## Assembly Order

Construct from the lowest layer upward, following the natural dependency graph:

```rust
async fn run(config: Config) -> anyhow::Result<()> {
    // 1. Infrastructure
    let db = Database::connect(&config.database).await?;

    // 2. Services (depend on infrastructure)
    let user_service = UserService::new(db.clone());
    let auth_service = AuthService::new(db.clone());

    // 3. Application (depends on services)
    let app = App::new(user_service, auth_service);

    // 4. Start
    app.start().await
}
```

## Rules

- All dependencies are constructed at the top of `run()`,
  before any business logic executes.
  New dependencies are not created mid-execution.
- Dependencies are passed through function parameters or struct fields.
  Global state (`static`, `lazy_static`, `OnceLock` for services) is forbidden.
- The parameter list of `run()` reflects the program's complete external input:
  configuration, plus optional test doubles for integration testing.
