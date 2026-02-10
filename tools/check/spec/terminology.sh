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

    # strip inline code spans before checking prose
    prose="$(echo "$line" | sed 's/`[^`]*`//g')"

    # "lib crate" in prose should be "library crate"
    if echo "$prose" | ggrep -iq '\blib crate\b'; then
      echo "TERMINOLOGY: $file:$line_num — use \"library crate\" instead of \"lib crate\""
      errors=$((errors + 1))
    fi

    # "bin crate" in prose should be "binary crate"
    if echo "$prose" | ggrep -iq '\bbin crate\b'; then
      echo "TERMINOLOGY: $file:$line_num — use \"binary crate\" instead of \"bin crate\""
      errors=$((errors + 1))
    fi
  done < "$file"
done < <(find "$SPEC_DIR" -name '*.md' -type f)

if [[ $errors -gt 0 ]]; then
  echo ""
  echo "Found $errors terminology violation(s)."
  exit 1
fi

echo "All spec terminology correct."
