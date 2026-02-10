# Model Selection

Guidelines for selecting the appropriate model for an agent.

## Model Options

| Model    | Use when                                                         |
| -------- | ---------------------------------------------------------------- |
| `opus`   | Deep reasoning, architecture decisions, complex multi-step tasks |
| `sonnet` | Standard tasks, code modification, search and analysis           |
| `haiku`  | Simple mechanical tasks, format checks, single-step operations   |

Avoid `inherit`. Choose the minimum model that handles the task.
