#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="$(cd "$(dirname "$0")/../../../spec" && pwd)"
errors=0

# conventional uppercase file names
is_allowed_uppercase() {
  local name="$1"
  case "$name" in
    CHANGELOG.md|README.md|VERSION) return 0 ;;
    *) return 1 ;;
  esac
}

while IFS= read -r entry; do
  name="$(basename "$entry")"

  if is_allowed_uppercase "$name"; then
    continue
  fi

  # kebab-case: lowercase letters, digits, hyphens, dots only
  if [[ ! "$name" =~ ^[a-z0-9][a-z0-9.\-]*$ ]]; then
    echo "BAD NAME: $entry"
    errors=$((errors + 1))
  fi
done < <(find "$SPEC_DIR" -mindepth 1 \( -type f -o -type d \))

if [[ $errors -gt 0 ]]; then
  echo ""
  echo "Found $errors naming violation(s)."
  exit 1
fi

echo "All spec file and directory names valid."
