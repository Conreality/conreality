PACKAGE_NAME    = consensus
PACKAGE_TARNAME = $(PACKAGE_NAME)
PACKAGE_VERSION = $(shell cat VERSION)

OCAMLBUILD      = ocamlbuild
OCAMLC          = ocamlfind ocamlc
OCAMLOPT        = ocamlfind ocamlopt
OPAM_INSTALLER  = opam-installer

BINARIES =                 \
  _build/src/consensus.cmo \
  _build/src/consensus.cmx

all: build

META: META.in Makefile VERSION
	sed -e 's:@PACKAGE_NAME@:$(PACKAGE_NAME):'       \
	    -e 's:@PACKAGE_TARNAME@:$(PACKAGE_TARNAME):' \
	    -e 's:@PACKAGE_VERSION@:$(PACKAGE_VERSION):' \
	    META.in > META

_build/src/consensus.cmo: src/consensus.mlpack _tags
	$(OCAMLBUILD) -Is src src/consensus.cmo

_build/src/consensus.cmx: src/consensus.mlpack _tags
	$(OCAMLBUILD) -Is src src/consensus.cmx

build: META $(BINARIES)

check:
	# TODO

install: consensus.install build
	$(OPAM_INSTALLER) consensus.install

uninstall: consensus.install
	$(OPAM_INSTALLER) -u consensus.install

clean:
	rm -rf _build META *~ src/*~ src/*.{a,cma,cmi,cmo,cmx,cmxa,ml.depends,mli.depends,o}

.PHONY: all build check install uninstall clean
