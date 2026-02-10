# Dependency Assembly

## Principle

Manual assembly. The type system is the dependency injection container.

All dependencies are constructed by hand in the orchestration function
and passed explicitly. No DI framework.
A missing dependency is a compile-time error.

For language-specific assembly examples, see [lang/](lang/).

## Assembly Site

Only in the orchestration function.
The entry point does not construct dependencies.

## Assembly Order

Construct from the lowest layer upward, following the natural dependency graph:

1. **Infrastructure** — database connections, external clients.
2. **Services** — depend on infrastructure.
3. **Application** — depends on services.
4. **Start** — launch the application.

## Rules

- All dependencies are constructed at the top of the orchestration function,
  before any business logic executes.
  New dependencies are not created mid-execution.
- Dependencies are passed through function parameters or struct fields.
  Global state (module-level statics, lazy singletons) is forbidden.
- The parameter list of the orchestration function reflects
  the program's complete external input:
  configuration, plus optional test doubles for integration testing.
