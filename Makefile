#
# Build scripts for chchef. Shamelessly stolen from postmodern's
# software.
#
NAME=chchef
VERSION=0.2.0
AUTHOR=tubbo
URL=https://github.com/$(AUTHOR)/$(NAME)

DIRS=share
INSTALL_DIRS=`find $(DIRS) -type d 2>/dev/null`
INSTALL_FILES=`find $(DIRS) -type f 2>/dev/null`
DOC_FILES=docs/man/*.md

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG).asc

PREFIX?=/usr/local
DOC_DIR=$(PREFIX)/share/doc/$(PKG_NAME)

all: clean share/man/man1/chchef.1

pkg:
	mkdir -p $(PKG_DIR)

download: pkg
	wget -O $(PKG) $(URL)/archive/v$(VERSION).tar.gz

build: pkg
	git archive --output=$(PKG) --prefix=$(PKG_NAME)/ HEAD

sign: $(PKG)
	gpg --sign --detach-sign --armor $(PKG)
	git add $(PKG).asc
	git commit $(PKG).asc -m "Added PGP signature for v$(VERSION)"
	git push origin master

verify: $(PKG) $(SIG)
	gpg --verify $(SIG) $(PKG)

clean:
	rm -f $(PKG) $(SIG)
	rm -f share/doc/man1/$(NAME).1

check:
	shellcheck share/$(NAME)/*.sh

test:
	bats test

tag:
	git push origin master
	git tag -s -m "Release v$(VERSION)" v$(VERSION)
	git push origin master --tags

release: share/man/man1/chchef.1 tag download sign

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done
	mkdir -p $(DESTDIR)$(DOC_DIR)
	cp -r $(DOC_FILES) $(DESTDIR)$(DOC_DIR)/

uninstall:
	for file in $(INSTALL_FILES); do rm -f $(DESTDIR)$(PREFIX)/$$file; done
	rm -rf $(DESTDIR)$(DOC_DIR)

/usr/local/bin/kramdown-man:
	sudo gem install kramdown-man

share/man/man1/chchef.1: /usr/local/bin/kramdown-man docs/man/${NAME}.1.md
	mkdir -p share/man/man1
	kramdown-man docs/man/${NAME}.1.md > share/man/man1/${NAME}.1
	git add share/man/man1/chchef.1
	git commit -m "Regenerated docs for ${VERSION}" share/man/man1/chchef.1

.PHONY: build download sign verify clean check test tag release install uninstall all
