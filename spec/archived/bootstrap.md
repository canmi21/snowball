# Bootstrap Phase

## Definition

The bootstrap phase is the period during which the spec is being
initially created and has not yet reached self-hosting capability.

During bootstrap, the spec cannot fully govern its own modification
because the rules for self-modification are themselves being written.

## Rules During Bootstrap

- Commits use the `spec` type and follow the format in
  [commit-message](../foundation/git/commit-message.md), but strict cross-area
  splitting is not enforced.
- Multiple logical changes may be grouped in a single commit
  when the spec is evolving rapidly.
- The goal is to reach self-hosting as quickly as possible.

## Transition to Self-Hosting

The bootstrap phase ends when the maintainer declares self-hosting.
The declaration is a commit that:

1. Updates [VERSION](../VERSION) with the current timestamp.
2. Adds a CHANGELOG entry marking the transition.
3. Removes or archives this file.

After self-hosting, all spec modifications follow the full
[evolution process](../foundation/evolution/process.md).

## Post-Bootstrap

Once self-hosting is declared:

- Corrective changes follow the fast path (see [process](../foundation/evolution/process.md)).
- Breaking changes follow the full evolution process.
- LLM agents modifying the spec must immediately comply
  with the updated rules (see [writing-style](../foundation/writing-style.md)).
