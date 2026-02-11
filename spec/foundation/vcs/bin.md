# VCS — Binary Crates

Follows the shared rules in [commit-message](commit-message.md),
[commit-scope](commit-scope.md), and [bookmarks](bookmarks.md).

## Additional Rules

### Configuration Changes

Changes to configuration format (new fields, renamed fields, changed defaults)
use `change` or `break`, not `refactor`.
Configuration format is a user-facing contract.

### Deployment-Relevant Changes

Changes to startup behavior, shutdown behavior, or signal handling
should include a brief note in the commit body
describing the operational impact.

### Commit Scope

App repositories use internal module or area names as commit scope.
See [commit-scope](commit-scope.md#app-repository-scope) for details.
