# Observability

## Core Principle

Libraries do not log. All information flows through return values and error types.
Observation and recording are the caller's policy, not the library's behavior.

## Zero Logging

No logging calls, no printing to standard output or standard error,
no event emission of any kind in library crates.

Event-style observability calls (structured logging, event macros)
are disguised logging. They push information to the caller without
being asked — the same violation as printing.

## Span Instrumentation — The One Exception

Passive span annotation is allowed because it marks
"I am inside this function" and lets the caller's subscriber
decide whether to collect the span.

### Rules

- Span instrumentation must be behind an optional feature flag
  (see [feature-flag](feature-flag.md) for the feature flag rules).
- When the feature is disabled, there is zero runtime cost.

This is particularly valuable for async code, where traditional stack traces
are ineffective and spans are the primary debugging mechanism.

For language-specific instrumentation syntax, see [lang/](lang/).
