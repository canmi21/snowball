# Creation Process

When creating a new agent, the main LLM presents interactive
choices to the user for each decision:

1. **Purpose** — what the agent does, presented for confirmation.
2. **Model** — options with a recommended default based on
   task complexity (see [model selection](model-selection.md)).
3. **Memory** — whether the agent needs persistent memory
   (see [memory](../agent/overview.md#memory)).
4. **Tools** — which tools the agent requires.

Each choice is presented as a selection with rationale.
The user confirms or overrides. No agent is created without
explicit user approval of all four decisions.

After creation, the agent must be registered in the
[registry](registry.md).
