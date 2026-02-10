#!/usr/bin/env bash
set -euo pipefail

# Validates commit message format then executes jj commit or split.
#
# Usage:
#   tools/vcs/commit.sh -m "type(scope): description"
#     → jj commit -m (commits entire working copy)
#
#   tools/vcs/commit.sh -m "type(scope): description" -- file1 file2 ...
#     → jj describe -m + jj split (keeps specified files, rest moves to child)

VALID_TYPES="add|fix|change|rm|break|refactor|doc|test|spec|ci|chore"
FORMAT_RE="^(${VALID_TYPES})\([a-z][a-z0-9-]*\): [a-z].*[^.]$"

msg=""
files=()
parsing_files=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -m) msg="$2"; shift 2 ;;
    --) parsing_files=true; shift ;;
    *)
      if $parsing_files; then
        files+=("$1")
      fi
      shift
      ;;
  esac
done

if [[ -z "$msg" ]]; then
  echo "ERROR: no commit message provided. Use -m \"message\"."
  exit 1
fi

# extract subject line (first line)
subject="$(echo "$msg" | head -1)"

# validate format: type(scope): lowercase description, no trailing period
if ! echo "$subject" | ggrep -qP "$FORMAT_RE"; then
  echo "REJECTED: subject does not match type(scope): description format."
  echo "  subject: $subject"
  echo "  valid types: ${VALID_TYPES//|/, }"
  exit 1
fi

# validate length
if [[ ${#subject} -gt 72 ]]; then
  echo "REJECTED: subject exceeds 72 characters (${#subject} chars)."
  echo "  subject: $subject"
  exit 1
fi

# validate no footer in body
body="$(echo "$msg" | tail -n +2)"
if [[ -n "$body" ]] && echo "$body" | ggrep -qP '^[A-Za-z-]+: |^[A-Za-z-]+ #'; then
  echo "REJECTED: commit body contains a footer section."
  exit 1
fi

# execute jj command
if [[ ${#files[@]} -gt 0 ]]; then
  # split mode: describe current change, then split specified files out
  jj describe -m "$msg"
  JJ_EDITOR=true jj split -- "${files[@]}"
else
  # single commit: commit entire working copy
  jj commit -m "$msg"
fi
