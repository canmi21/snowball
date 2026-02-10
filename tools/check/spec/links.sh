#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="$(cd "$(dirname "$0")/../../../spec" && pwd)"
errors=0
link_re='\[([^]]*)\]\(([^)]+)\)'

while IFS= read -r file; do
  dir="$(dirname "$file")"
  line_num=0

  in_code_block=false

  while IFS= read -r line; do
    line_num=$((line_num + 1))

    # toggle code block state
    if [[ "$line" =~ ^\`\`\` ]]; then
      if $in_code_block; then
        in_code_block=false
      else
        in_code_block=true
      fi
      continue
    fi
    $in_code_block && continue

    rest="$line"

    while [[ "$rest" =~ $link_re ]]; do
      target="${BASH_REMATCH[2]}"
      rest="${rest#*"${BASH_REMATCH[0]}"}"

      # skip external links and anchors
      if [[ "$target" == http://* || "$target" == https://* || "$target" == \#* ]]; then
        continue
      fi

      # strip anchor fragment
      target="${target%%#*}"

      resolved="$dir/$target"
      if [[ ! -e "$resolved" ]]; then
        echo "BROKEN LINK: $file:$line_num -> $target"
        errors=$((errors + 1))
      fi
    done
  done < "$file"
done < <(find "$SPEC_DIR" -name '*.md' -type f)

if [[ $errors -gt 0 ]]; then
  echo ""
  echo "Found $errors broken link(s)."
  exit 1
fi

echo "All spec links valid."
