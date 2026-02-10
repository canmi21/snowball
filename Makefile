.PHONY: check check-spec \
       check-spec-links check-spec-line-count check-spec-naming \
       check-spec-forbidden-patterns check-spec-terminology \
       check-spec-changelog-format \
       fmt fmt-check

check: check-spec

fmt:
	@oxfmt --write spec/ CLAUDE.md

fmt-check:
	@oxfmt --check spec/ CLAUDE.md

check-spec: check-spec-links check-spec-line-count check-spec-naming \
            check-spec-forbidden-patterns check-spec-terminology \
            check-spec-changelog-format

check-spec-links:
	@tools/check/spec/links.sh

check-spec-line-count:
	@tools/check/spec/line-count.sh

check-spec-naming:
	@tools/check/spec/naming.sh

check-spec-forbidden-patterns:
	@tools/check/spec/forbidden-patterns.sh

check-spec-terminology:
	@tools/check/spec/terminology.sh

check-spec-changelog-format:
	@tools/check/spec/changelog-format.sh
