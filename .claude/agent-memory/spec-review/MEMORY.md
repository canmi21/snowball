# Spec Review Memory

## Last Full Review

- Date: 2026-02-11
- Spec version: 2026-02-11T06:43:33Z
- Total spec files: 70 .md files (including README.md and CHANGELOG.md)

## Resolved Since Last Review (2026-02-10)

All 10 previously reported findings have been resolved:

- #1 Rust filename contradiction: layout.md corrected
- #2 CHANGELOG archived refs: archived/ deleted; entries are historical
- #3 300-line duplication: roles.md uses "SCoL threshold" links now
- #4 Checklist numbering collision: prefix IDs (SS/SA/SFS/SFA) eliminate overlap
- #5 Missing commit script: compliance.md migrated to qwq CLI
- #6 directory.md missing .claude/: now in monorepo layout tree
- #7 Missing Unreleased section: spec.md explicitly exempts spec CHANGELOG
- #8 Feature flag composition gap: section added to feature-flag.md
- #9 archived/ broken links: directory deleted
- #10 archived/ not in README: directory deleted

## Active Findings

### Critical

1. **Path dependency contradiction** (repository.md vs strategy.md)
   - repository.md L34-35: "not through local path references"
   - repository.md L47-48: "They never reference the monorepo by path"
   - strategy.md L62: "it uses a path dependency pointing to ../../library/..."
   - Status: OPEN

### Important

2. **README compliance description stale** (README.md L46)
   - Says "shell scripts + LLM agent"; compliance.md now says "qwq CLI"
   - Status: OPEN

3. **Runtime Adaptation duplication** (naming/lang/rust.md vs naming/crate.md)
   - naming/lang/rust.md L9-16 is exact copy of naming/crate.md L69-75
   - Status: OPEN

4. **Publication lang/rust.md restates checklist** (publication/lang/rust.md)
   - L8-20 restates all 9 steps inline instead of linking
   - Status: OPEN

5. **Stale agent example in overview.md** (foundation/agent/overview.md L9)
   - References spec-check.md; that agent was merged into spec-bot
   - Status: OPEN

6. **trait-design.md filename vs content** (lib/contract/trait-design.md)
   - Filename uses "trait" (Rust-specific); heading says "Interface Design"
   - Status: OPEN

7. **Incomplete multi-language terminology migration** (foundation/)
   - trait-impl-separation.md: "trait" 7x in language-agnostic context
   - type-flow.md: "trait" 5x
   - roles.md: "trait bounds" 2x
   - crate.md: "trait definition crate"
   - directory.md: "Rust trait definition"
   - Status: OPEN

### Minor

8. **layout.md treats depth threshold as hard limit** (bin/structure/layout.md L26)
   - "must stay under 4 levels" vs heuristics philosophy of evaluation triggers
   - Status: OPEN

## Verified Non-Issues

- No "lib crate" or "bin crate" in prose
- No emoji in spec files
- All lang/ directory links resolve correctly
- Agent registry matches actual agent files (3: spec-bot, spec-review, vcs-bot)
- CHANGELOG historical entries are factual records
- qwq.toml references consistent throughout
- No cargo fmt/clippy in active spec files
- lib/practices/naming.md is proper redirect (not duplication)
