# Code Comments

Follows the general rules in [general](general.md).

For language-specific comment conventions, see [lang/](lang/).

## When to Write

Write an inline comment only when the logic is not self-evident
from the code, types, and surrounding context.

If a block of code requires a comment to be understood,
first consider whether renaming variables or extracting a function
would make the comment unnecessary.

## TODO and FIXME

`TODO` and `FIXME` are permitted as temporary development markers
during active work. They serve as reminders for incomplete or
incorrect code across multi-day development sessions.

**Pre-publish requirement**: all `TODO` and `FIXME` markers must be resolved
before a package is published. Zero remaining markers at publication time.
This is part of the [pre-publish checklist](../../../foundation/publication/checklist.md).
