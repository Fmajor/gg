prefix=/usr/local
SCRIPT_FILES=$(shell ls gg-*)

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	mkdir -p build
	@for each in $(SCRIPT_FILES); \
	do \
		sed "s#installPath=.*#installPath=$(prefix)/bin#g" $$each > build/$$each; \
	done
	cd build && install -d -m 0755 $(prefix)/bin && install $(SCRIPT_FILES) $(prefix)/bin

uninstall:
	test -d $(prefix)/bin && \
	cd $(prefix)/bin && \
	rm -f $(SCRIPT_FILES)