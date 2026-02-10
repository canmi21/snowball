# Registry

All agents must be registered in this table.
The table is the single source of truth for agent inventory.

| Agent          | Model  | Memory | Purpose                                             |
| -------------- | ------ | ------ | --------------------------------------------------- |
| `spec-cascade` | haiku  | no     | Complete cascading updates after spec changes       |
| `spec-check`   | haiku  | no     | Run compliance checks and report results            |
| `spec-commit`  | sonnet | no     | Analyze changes and create correctly scoped commits |
| `spec-review`  | opus   | yes    | Layer 2 semantic review of the entire spec          |
