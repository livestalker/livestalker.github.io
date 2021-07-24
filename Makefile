.PHONY: server
server:
	hugo server --watch

.PHONY: build
build:
	hugo

.PHONY: update-theme
update-theme:
	git submodule update --remote --merge