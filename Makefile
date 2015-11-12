PACKAGE_NAME    = consensus
PACKAGE_TARNAME = $(PACKAGE_NAME)
PACKAGE_VERSION = $(shell cat VERSION)

OCAMLBUILD      = ocamlbuild
OCAMLC          = ocamlfind ocamlc
OCAMLOPT        = ocamlfind ocamlopt
OPAM_INSTALLER  = opam-installer
CHECKSEDSCRIPT  = ''

ifeq ($(V),1)
OCAMLBUILD      = ocamlbuild -verbose 1 -cflag -verbose -lflag -verbose
CHECKSEDSCRIPT  = 's/$$/ --verbose/'
endif

BINARIES = \
  _build/src/consensus.otarget

all: build

META: META.in Makefile VERSION
	sed -e 's:@PACKAGE_NAME@:$(PACKAGE_NAME):'       \
	    -e 's:@PACKAGE_TARNAME@:$(PACKAGE_TARNAME):' \
	    -e 's:@PACKAGE_VERSION@:$(PACKAGE_VERSION):' \
	    META.in > META

_build/src/consensus.otarget: src/consensus.itarget src/consensus.mlpack _tags
	$(OCAMLBUILD) -Is src src/consensus.otarget

build: META $(BINARIES)

check:
	CAML_LD_LIBRARY_PATH=src/consensus:$(CAML_LD_LIBRARY_PATH) \
	  $(OCAMLBUILD) -Is test,src test/check.otarget && \
	  cp -p test/check_all.sh _build/test/ && \
	  sed -i -e $(CHECKSEDSCRIPT) _build/test/check_all.sh && \
	  _build/test/check_all.sh

install: consensus.install build
	$(OPAM_INSTALLER) consensus.install

uninstall: consensus.install
	$(OPAM_INSTALLER) -u consensus.install

clean:
	$(OCAMLBUILD) -clean
	rm -rf _build META *~ src/*~ src/*.{a,cma,cmi,cmo,cmx,cmxa,ml.depends,mli.depends,o}

.PHONY: all build check install uninstall clean
