.PHONY: check fmt fmt-check

check:
	@qwq check

fmt:
	@oxfmt --write spec/ CLAUDE.md

fmt-check:
	@oxfmt --check spec/ CLAUDE.md
