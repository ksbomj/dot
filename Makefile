HOME_DIRS = \
	. \
	$(HOME)/.emacs.d

SYMLINKS = \
	$(HOME)/.emacs.d/init.el \
	$(HOME)/.emacs.d/settings \
	$(HOME)/.emacs.d/themes \
	$(HOME)/.emacs.d/mods \
        $(HOME)/.emacs.d/org

OPENBSD_SYMLINKS = \
	$(HOME)/.xsession \
	$(HOME)/.Xresources

LANGUAGES = \
	languages/go

ln=ln -s

.PHONY: setup
OS=$(shell uname -s)
setup: ## Machine setup
ifeq ($(OS), Darwin)
	@make macos/setup
endif

languages: | $(LANGUAGES) ## Configures programming languges

languages/go:
	GO111MODULE=on go get golang.org/x/tools/gopls@latest

macos/setup: common/dirs common/symlinks macos/setup/programs  macos/setup/fonts languages  ## Setup for MacOS

macos/setup/programs:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install go

macos/setup/fonts:
	brew install svn emacs
	brew tap homebrew/cask-fonts
	brew install --cask font-fira-code font-cantarell

openbsd/setup: common/dirs common/symlinks ## Setup for OpenBSD

freebsd/setup: common/dirs common/symlinks   ## Setup for FreeBSD

guix/setup: common/dirs common/symlinks        ## Setup for Guix

.PHONY: help
help:
	@grep -E '^[a-zA-Z_()$$. /-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

common/symlinks: | $(SYMLINKS) 

$(HOME)/.emacs.d/init.el: | $(HOME)/.emacs.d
	$(ln) $(PWD)/emacs/init.el $@

$(HOME)/.emacs.d/settings: | $(HOME)/.emacs.d/settings
	$(ln) $(PWD)/emacs/settings $@

$(HOME)/.emacs.d/themes: | $(HOME)/.emacs.d/themes
	$(ln) $(PWD)/emacs/themes $@

$(HOME)/.emacs.d/mods: | $(HOME)/.emacs.d/mods
	$(ln) $(PWD)/emacs/mods $@

$(HOME)/.emacs.d/org: | $(HOME)/.emacs.d/org
	$(ln) $(PWD)/emacs/org $@

common/dirs: | $(HOME_DIRS)

$(HOME)/.emacs.d:
	mkdir -p $(HOME)/.emacs.d

openbsd/symlinks: | $(OPENBSD_SYMLINKS) ## Configures OpenBSD symlinks

$(HOME)/.xsession:
	$(ln) $(PWD)/openbsd/.xsession

$(HOME)/.Xresources:
	$(ln) $(PWD)/openbsd/.Xresources

