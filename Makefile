PACKAGE_NAME    = consensus
PACKAGE_TARNAME = $(PACKAGE_NAME)
PACKAGE_VERSION = $(shell cat VERSION)

OCAMLBUILD      = ocamlbuild
OPAM_INSTALLER  = opam-installer

BINARIES = _build/src/$(PACKAGE_TARNAME).cma _build/src/$(PACKAGE_TARNAME).cmxa

all: build

META: META.in Makefile VERSION
	sed -e 's:@PACKAGE_NAME@:$(PACKAGE_NAME):'       \
	    -e 's:@PACKAGE_TARNAME@:$(PACKAGE_TARNAME):' \
	    -e 's:@PACKAGE_VERSION@:$(PACKAGE_VERSION):' \
	    META.in > META

_build/src/$(PACKAGE_TARNAME).cma: src/$(PACKAGE_TARNAME).mli src/$(PACKAGE_TARNAME).ml
	$(OCAMLBUILD) -Is src src/$(PACKAGE_TARNAME).cma

_build/src/$(PACKAGE_TARNAME).cmxa: src/$(PACKAGE_TARNAME).mli src/$(PACKAGE_TARNAME).ml
	$(OCAMLBUILD) -Is src src/$(PACKAGE_TARNAME).cmxa

build: META $(BINARIES)

check:
	# TODO

install: $(PACKAGE_TARNAME).install build
	$(OPAM_INSTALLER) $(PACKAGE_TARNAME).install

uninstall: $(PACKAGE_TARNAME).install
	$(OPAM_INSTALLER) -u $(PACKAGE_TARNAME).install

clean:
	rm -rf _build META *~ src/*~ src/*.{a,cma,cmi,cmo,cmx,cmxa,ml.depends,mli.depends,o}

.PHONY: all build check install uninstall clean
