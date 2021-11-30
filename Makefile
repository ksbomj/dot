HOME_DIRS = \
	. \
	$(HOME)/.emacs.d

SYMLINKS = \
	$(HOME)/.emacs.d/init.el

OPENBSD_SYMLINKS = \
	$(HOME)/.xsession \
	$(HOME)/.Xresources

ln=ln -s

.PHONY: setup
OS=$(shell uname -s)
setup: ## Machine setup
ifeq ($(OS), Darwin)
	@make macos/setup
endif

macos/setup: common/dirs common/symlinks ## Setup for MacOS

openbsd/setup: common/dirs common/symlinks ## Setup for OpenBSD

guix/setup: common/dirs common/symlinks ## Setup for Guix

.PHONY: help
help:
	@grep -E '^[a-zA-Z_()$$. /-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

common/symlinks: | $(SYMLINKS)  ## Configures a common symlinks

$(HOME)/.emacs.d/init.el: | $(HOME)/.emacs.d ## Emacs initialization file
	$(ln) $(PWD)/emacs/init.el $@

common/dirs: | $(HOME_DIRS) ## Creates a common directory

$(HOME)/.emacs.d:
	mkdir -p $(HOME)/.emacs.d

openbsd/symlinks: | $(OPENBSD_SYMLINKS) ## Configures OpenBSD symlinks

$(HOME)/.xsession:
	$(ln) $(PWD)/openbsd/.xsession

$(HOME)/.Xresources:
	$(ln) $(PWD)/openbsd/.Xresources

