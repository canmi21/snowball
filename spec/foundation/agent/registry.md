# Registry

All agents must be registered in this table.
The table is the single source of truth for agent inventory.

| Agent         | Model  | Memory | Purpose                                       |
| ------------- | ------ | ------ | --------------------------------------------- |
| `spec-bot`    | sonnet | no     | Spec operations: find, modify, cascade, check |
| `spec-review` | opus   | yes    | Layer 2 semantic review of the entire spec    |
| `vcs-bot`     | sonnet | no     | Full VCS workflow: diff, commit, land, push   |
