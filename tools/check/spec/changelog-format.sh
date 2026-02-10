#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="$(cd "$(dirname "$0")/../../../spec" && pwd)"
CHANGELOG="$SPEC_DIR/CHANGELOG.md"
errors=0

# check file exists
if [[ ! -f "$CHANGELOG" ]]; then
  echo "MISSING: spec/CHANGELOG.md"
  exit 1
fi

# check header preamble
if ! head -3 "$CHANGELOG" | ggrep -q '# Changelog'; then
  echo "FORMAT: spec/CHANGELOG.md missing '# Changelog' header"
  errors=$((errors + 1))
fi

# check version entries use timestamp format
timestamp_re='## \[[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z\]'
while IFS= read -r line; do
  # lines starting with ## [ should be version entries
  if [[ "$line" == "## ["* ]]; then
    if ! echo "$line" | ggrep -Pq "$timestamp_re"; then
      echo "FORMAT: invalid version entry: $line"
      errors=$((errors + 1))
    fi
  fi
done < "$CHANGELOG"

# check category order within each version entry
# expected: Breaking, Added, Changed, Fixed, Removed
cat_order() {
  case "$1" in
    Breaking) echo 1 ;;
    Added)    echo 2 ;;
    Changed)  echo 3 ;;
    Fixed)    echo 4 ;;
    Removed)  echo 5 ;;
    *)        echo 0 ;;
  esac
}

current_version=""
last_order=0

while IFS= read -r line; do
  if [[ "$line" == "## ["* ]]; then
    current_version="$line"
    last_order=0
    continue
  fi

  if [[ "$line" == "### "* ]]; then
    category="${line#"### "}"
    order="$(cat_order "$category")"

    if [[ $order -eq 0 ]]; then
      echo "FORMAT: unknown category '$category' in $current_version"
      errors=$((errors + 1))
    elif [[ $order -lt $last_order ]]; then
      echo "FORMAT: wrong category order '$category' in $current_version (expected: Breaking, Added, Changed, Fixed, Removed)"
      errors=$((errors + 1))
    fi
    last_order=$order
  fi
done < "$CHANGELOG"

if [[ $errors -gt 0 ]]; then
  echo ""
  echo "Found $errors CHANGELOG format issue(s)."
  exit 1
fi

echo "Spec CHANGELOG format valid."
