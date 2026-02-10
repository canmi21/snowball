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

  # parse [[entry]] blocks — match file + check + hash within the same entry
  local match_file=0 match_check=0 match_hash=0

  while IFS= read -r line; do
    if [[ "$line" == "[[entry]]" ]]; then
      if [[ $match_file -eq 1 && $match_check -eq 1 && $match_hash -eq 1 ]]; then
        return 0
      fi
      match_file=0; match_check=0; match_hash=0
    fi

    [[ "$line" == "file = \"$rel_path\"" ]] && match_file=1
    [[ "$line" == "check = \"$check\"" ]] && match_check=1
    [[ "$line" == "hash = \"$file_hash\"" ]] && match_hash=1
  done < "$ALLOWLIST"

  # check last entry
  if [[ $match_file -eq 1 && $match_check -eq 1 && $match_hash -eq 1 ]]; then
    return 0
  fi

  return 1
}

while IFS= read -r file; do
  basename="$(basename "$file")"

  # skip data files that grow naturally
  if [[ "$basename" == "CHANGELOG.md" || "$basename" == "README.md" ]]; then
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
