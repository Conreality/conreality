PACKAGE_NAME    = consensus
PACKAGE_TARNAME = $(PACKAGE_NAME)
PACKAGE_VERSION = $(shell cat VERSION)

OCAMLBUILDFLAGS = -use-ocamlfind -plugin-tag 'package(cppo_ocamlbuild)'
OCAMLCFLAGS     =
OCAMLOPTFLAGS   = $(OCAMLCFLAGS)

OCAMLBUILD      = ocamlbuild $(OCAMLBUILDFLAGS) $(OCAMLCFLAGS)
OCAMLC          = ocamlfind ocamlc $(OCAMLCFLAGS)
OCAMLOPT        = ocamlfind ocamlopt $(OCAMLOPTFLAGS)
COREBUILD       = corebuild $(OCAMLCFLAGS)
OPAM_INSTALLER  = opam-installer
RUBY            = ruby

BENCHABLE_ARCHITECTURES := x86_|i686
IS_BENCHABLE_ARCHITECTURE := $(shell \
  uname -m | \
  egrep "($(BENCHABLE_ARCHITECTURES))" 2>&1 >/dev/null && \
  echo true || echo false)

ifeq ($(V),1)
OCAMLBUILD      = ocamlbuild -verbose 1 -cflag -verbose -lflag -verbose $(OCAMLBUILDFLAGS) $(OCAMLCFLAGS)
CHECKVERBOSE	= '--verbose'
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
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/conctl.native: src/conctl.ml _tags
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/conreald.native: src/conreald.ml _tags
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/consensus.docdir/index.html: src/consensus.odocl
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/consensus.docdir/man: src/consensus.odocl
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/consensus.docdir/reference.tex: src/consensus.odocl
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/consensus.docdir/reference.texi: src/consensus.odocl
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

_build/src/consensus.docdir/reference.dot: src/consensus.odocl
	$(OCAMLBUILD) -Is src $(patsubst _build/%,%,$@)

build: META $(BINARIES)

conctl: _build/src/conctl.native

conreald: _build/src/conreald.native

html: _build/src/consensus.docdir/index.html

man: _build/src/consensus.docdir/man

tex: _build/src/consensus.docdir/reference.tex

texi: _build/src/consensus.docdir/reference.texi

dot: _build/src/consensus.docdir/reference.dot

doc: html man tex texi dot

check:
	mkdir -p tmp/check && \
	$(RUBY) etc/script/precoverage.rb && \
	cd tmp/check && \
	CAML_LD_LIBRARY_PATH=src:$(CAML_LD_LIBRARY_PATH) \
	  $(OCAMLBUILD) -Is test,src test/check.otarget && \
	  cp -p test/check_all.sh _build/test/ && \
	CAML_LD_LIBRARY_PATH=_build/src:$(CAML_LD_LIBRARY_PATH) BISECT_FILE=bisect \
	  _build/test/check_all.sh $(CHECKVERBOSE)

ifeq "$(IS_BENCHABLE_ARCHITECTURE)" "true"
bench:
	CAML_LD_LIBRARY_PATH=src:$(CAML_LD_LIBRARY_PATH) \
	  $(COREBUILD) -Is bench,src bench/bench.otarget && \
	  cp -p bench/bench_all.sh _build/bench/ && \
	CAML_LD_LIBRARY_PATH=_build/src:$(CAML_LD_LIBRARY_PATH) \
	  _build/bench/bench_all.sh
else
bench:
	echo "Benchmarking is currently supported only on these \
	  architectures: $(BENCHABLE_ARCHITECTURES)"
endif

clean-reports:
	rm -rf tmp/report

report: clean-reports
	mkdir -p tmp/report && \
	cd tmp/check/_build && \
	bisect-ppx-report -verbose -html ../../report ../bisect*.out && \
	cd -

install: consensus.install build
	$(OPAM_INSTALLER) consensus.install

uninstall: consensus.install
	$(OPAM_INSTALLER) -u consensus.install

clean:
	$(OCAMLBUILD) -clean
	rm -rf META README.html _build _tests *~ src/*~ src/*.{a,cma,cmi,cmo,cmp,cmx,cmxa,ml.depends,mli.depends,o} tmp _bisect _reports

.PHONY: all build check bench install uninstall clean
