#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="$(cd "$(dirname "$0")/../../../spec" && pwd)"
errors=0

while IFS= read -r file; do
  line_num=0
  in_code_block=false

  while IFS= read -r line; do
    line_num=$((line_num + 1))

    if [[ "$line" =~ ^\`\`\` ]]; then
      if $in_code_block; then
        in_code_block=false
      else
        in_code_block=true
      fi
      continue
    fi
    $in_code_block && continue

    # check for emoji and decorative non-ASCII symbols
    if echo "$line" | ggrep -Pq '[\x{1F000}-\x{1FFFF}\x{2600}-\x{27BF}\x{FE00}-\x{FE0F}\x{200D}]'; then
      echo "EMOJI: $file:$line_num"
      errors=$((errors + 1))
    fi
  done < "$file"
done < <(find "$SPEC_DIR" -name '*.md' -type f)

if [[ $errors -gt 0 ]]; then
  echo ""
  echo "Found $errors forbidden pattern(s)."
  exit 1
fi

echo "No forbidden patterns found in spec files."
