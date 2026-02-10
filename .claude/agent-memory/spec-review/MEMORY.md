# Spec Review Memory

## Last Full Review
- Date: 2026-02-10
- Spec version: 2026-02-10T10:32:33Z
- Total spec files: 64 .md files

## Active Findings

### Critical
1. **Rust filename convention contradiction** (layout.md vs file-structure.md)
   - `bin/structure/layout.md` line 33-34: "lowercase letters and hyphens only: shutdown-handler.rs"
   - `foundation/naming/file-structure.md` line 14: Rust uses "snake_case.rs"
   - Hyphens in Rust filenames break `mod` declarations
   - Status: OPEN

2. **CHANGELOG references nonexistent file path** (CHANGELOG.md lines 67, 112)
   - References `foundation/evolution/bootstrap.md` which was moved to `archived/bootstrap.md`
   - Archived files are excluded from link check, and CHANGELOG references are in backtick-quoted file lists (not links), so not caught by scripts
   - Status: OPEN

### Important
3. **300-line threshold duplication** (roles.md, stateless-sync.md vs heuristics.md)
   - Number "300" restated 8x in roles.md, 2x in stateless-sync.md
   - heuristics.md is the single source, but roles.md and stateless-sync.md restate the number inline instead of just linking
   - Status: OPEN

4. **Checklist numbering collision** (stateful-async.md)
   - Inherits items from stateless-async (11-16) and stateful-sync (11-18) which use overlapping numbers
   - Item 12 from stateless-async = "No concrete runtime" vs item 12 from stateful-sync = "Irreversible ops consume self"
   - Stateful-sync item 11 (lifecycle phases) silently excluded without explanation (13 and 17 are explained)
   - Status: OPEN

5. **Missing commit-message-format script** (compliance.md vs tools/)
   - compliance.md lists 7 Layer 1 checks including "Commit message format validation"
   - Only 6 scripts exist in tools/check/spec/ -- no commit message script
   - Status: OPEN

6. **directory.md omits .claude/agents/** (directory.md)
   - Monorepo layout tree does not show .claude/ directory
   - CLAUDE.md context detection table references it
   - Agent spec defines its location
   - Status: OPEN

7. **Missing Unreleased section in spec CHANGELOG** (CHANGELOG.md vs format.md)
   - format.md requires ## [Unreleased] section
   - spec/CHANGELOG.md has none
   - spec.md does not explicitly exempt spec from this requirement
   - Status: OPEN

8. **Feature flag rules gap for composition crates** (feature-flag.md)
   - Leaf and convergence crate feature rules defined
   - Composition crate rules absent (only mentioned in "Forbidden" section)
   - Status: OPEN

9. **archived/bootstrap.md has broken internal links** (archived/bootstrap.md)
   - Links to `process.md`, `../git/commit-message.md`, `../../VERSION`, `../writing-style.md` are all broken from archived/ location
   - Excluded from link checker, but still misleading if read
   - Status: OPEN

### Minor
10. **archived/bootstrap.md not in README index** (README.md)
    - Only archived/README.md is indexed; bootstrap.md is not listed
    - Status: OPEN

## Verified Non-Issues
- Terminology: no "lib crate" or "bin crate" in prose (correct)
- No emoji in spec files (correct)
- Archived excluded from link checks (by design)
- Spec CHANGELOG header matches spec.md template (paths adjusted correctly)
- lib/practices/naming.md is proper redirect (not duplication)
