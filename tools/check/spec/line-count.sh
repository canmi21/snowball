#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="$(cd "$(dirname "$0")/../../../spec" && pwd)"
REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
ALLOWLIST="$REPO_ROOT/tools/check/allowlist.toml"
THRESHOLD=100
errors=0

check_allowlist() {
  local file="$1"
  local check="$2"

  if [[ ! -f "$ALLOWLIST" ]]; then
    return 1
  fi

  local rel_path="${file#"$REPO_ROOT"/}"
  local file_hash
  file_hash="$(shasum -a 256 "$file" | cut -d' ' -f1)"

  # simple toml parse: look for matching file + check + hash
  if grep -q "file = \"$rel_path\"" "$ALLOWLIST" && \
     grep -q "check = \"$check\"" "$ALLOWLIST" && \
     grep -q "hash = \"$file_hash\"" "$ALLOWLIST"; then
    return 0
  fi

  return 1
}

while IFS= read -r file; do
  basename="$(basename "$file")"

  # skip CHANGELOG (data file, grows naturally)
  if [[ "$basename" == "CHANGELOG.md" ]]; then
    continue
  fi

  count="$(wc -l < "$file")"

  if [[ $count -gt $THRESHOLD ]]; then
    if check_allowlist "$file" "line-count"; then
      continue
    fi
    echo "OVER $THRESHOLD LINES: $file ($count lines)"
    errors=$((errors + 1))
  fi
done < <(find "$SPEC_DIR" -name '*.md' -type f)

if [[ $errors -gt 0 ]]; then
  echo ""
  echo "Found $errors file(s) over $THRESHOLD lines."
  exit 1
fi

echo "All spec files within line count threshold."
