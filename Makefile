# -*- mode: makefile -*-

PREFIX ?= /usr/local

.PHONY: help
help:
	@echo
	@echo "Not much to see here.  It seems more obvious to look at a Makefile for"
	@echo "options for working with the project, even if we're not really building"
	@echo "anything.  It beats searching for scripts.  In my humble opinion."
	@echo
	@echo "Targets include:"
	@echo "   help"
	@echo "      This page"
	@echo
	@echo "   man2html"
	@echo "      Generate an HTML file from the man page.  The main use of this"
	@echo "      target is to generate a HTML file to which README.md can link."
	@echo
	@echo "   install"
	@echo "      Install the utility in $(PREFIX)/bin and the"
	@echo "      man page in /usr/share/man/man1"
	@echo
	@echo "   uninstall"
	@echo "      Remove the utility from $(PREFIX)/bin and the"
	@echo "      man page from /usr/share/man/man1"
	@echo

.PHONY: man2html
man2html:
	groffer --html --to-stdout dhcp_scan.1 > dhcp_scan.html

.PHONY: install
install:
	ln -s $(abspath dhcp_scan) $(PREFIX)/bin
	gzip -c dhcp_scan.1 > dhcp_scan.1.gz
	sudo mv dhcp_scan.1.gz /usr/share/man/man1

.PHONY: uninstall
uninstall:
	rm -f $(PREFIX)/bin/dhcp_scan
	rm -f /usr/share/man/man1/dhcp_scan.1.gz

