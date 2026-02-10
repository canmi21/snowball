# Telemetry

Applies primarily to long-running services. CLI tools may opt in.

## Design Principle

The tracing subscriber is a replaceable component.
Different environments use different subscribers.

## Two-Step Initialization

Telemetry initializes in two steps to ensure that errors during
configuration loading are observable.

### Step 1 — Basic Init (before config)

Start a minimal subscriber using environment-based configuration
and default formatting. This captures any errors that occur
during the configuration loading phase.

### Step 2 — Reconfigure (after config)

Once configuration is loaded, reconfigure the subscriber
with the full telemetry settings from config
(output format, level overrides, export targets).

For CLI tools, step 2 may be omitted if environment-based
configuration is sufficient.

## Telemetry Module Responsibilities

- Construct, install, and reconfigure the global tracing subscriber.
- Provide an `init()` function that returns a reload handle
  and a flush-on-drop guard.
- Provide a `reconfigure()` function that applies full configuration.
- Alternatively, provide named constructors for distinct environments
  (production, test).

For language-specific telemetry implementation, see [lang/](lang/).

## Rules

- Subscriber construction logic lives only in the telemetry module.
- The entry point calls `init()` and `reconfigure()`.
  It does not know subscriber internals.
- Production: structured output (JSON or `key=value`).
- Development: human-readable output.
- Log level is controlled via environment variable
  or configuration, never hardcoded.

## Relationship to Library Observability

- Library crates produce zero log output
  (see [observability](../lib/practices/observability.md)).
- Library crates may annotate functions with span instrumentation
  behind an optional feature flag.
- The binary's subscriber activation is what makes
  library-level spans observable.
