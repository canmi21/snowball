# Documentation — General Rules

These rules apply to all forms of written text in code:
doc comments, inline comments, and safety annotations.

## Language

English. Declarative sentences.
Write statements of fact, not instructions to the reader.

## Content

- Describe **what** something does or **why** a decision was made.
  Do not describe **how** it works — the code itself expresses that.
- Do not state the obvious.
  A comment that repeats what the code already says adds noise.
- Every comment must carry information that is not already visible
  in the code, types, or function signatures.

## Formatting

- No decorative separators (`====`, `----`, `****`, `////`, or similar).
- No banner-style comment blocks.
- Keep comments concise. One or two sentences for inline comments.
  Doc comments may be longer when documenting error conditions and examples.
