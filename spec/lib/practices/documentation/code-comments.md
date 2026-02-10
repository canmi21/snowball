# Code Comments

Follows the general rules in [general](general.md).

## When to Write

Write an inline comment only when the logic is not self-evident
from the code, types, and surrounding context.

If a block of code requires a comment to be understood,
first consider whether renaming variables or extracting a function
would make the comment unnecessary.

## SAFETY Annotations

Required by clippy (`undocumented_unsafe_blocks`) before every `unsafe` block.

Format: `// SAFETY:` followed by a declarative sentence explaining
why the unsafe operation is sound — which invariants are upheld
and how they are guaranteed.

```rust
// SAFETY: The pointer is non-null because it was obtained from Box::into_raw
// and has not been deallocated since.
unsafe { *ptr }
```

The sentence must be specific to this call site.
Generic statements like "this is safe" or "the caller guarantees safety"
are not acceptable.

See [unsafe-code](../../../foundation/safety/unsafe-code.md) for the full
unsafe code policy.

## TODO and FIXME

`TODO` and `FIXME` are permitted as temporary development markers
during active work. They serve as reminders for incomplete or
incorrect code across multi-day development sessions.

```rust
// TODO: Handle the case where the connection is reset mid-transfer.
```

**Pre-publish requirement**: all `TODO` and `FIXME` markers must be resolved
before a crate is published. Zero remaining markers at publication time.
This is part of the [pre-publish checklist](../../../foundation/publication/checklist.md).
