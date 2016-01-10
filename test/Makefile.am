$(eval include $(top_srcdir)/src/Makefile.conf)

OCAMLCFLAGS  = $(AM_OCAMLCFLAGS)
OCAMLCFLAGS += -package alcotest
OCAMLCFLAGS += -I $(top_srcdir)/src/consensus $(top_srcdir)/src/consensus/consensus.cmo check_common.cmo
#OCAMLCFLAGS += -cclib -rdynamic -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/libconreality.a -cclib -Wl,--no-whole-archive

include $(top_srcdir)/src/Makefile.rules

check_PROGRAMS = \
  check_config         \
  check_geometry       \
  check_knowledge      \
  check_machinery      \
  check_measures       \
  check_messaging      \
  check_model          \
  check_networking     \
  check_ontology       \
  check_physics        \
  check_prelude        \
  check_prelude_bool   \
  check_prelude_bytes  \
  check_prelude_char   \
  check_prelude_float  \
  check_prelude_int    \
  check_prelude_math   \
  check_prelude_option \
  check_prelude_posix  \
  check_prelude_string \
  check_scripting      \
  check_syntax         \
  check_vision

# FIXME: this works, but results in lots of GNU Make warnings.
#$(check_PROGRAMS): %: %.ml
#	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

$(check_PROGRAMS): check_common.cmo

check_config: check_config.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_geometry: check_geometry.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_knowledge: check_knowledge.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_machinery: check_machinery.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_measures: check_measures.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_messaging: check_messaging.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_model: check_model.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_networking: check_networking.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_ontology: check_ontology.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_physics: check_physics.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude: check_prelude.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_bool: check_prelude_bool.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_bytes: check_prelude_bytes.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_char: check_prelude_char.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_float: check_prelude_float.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_int: check_prelude_int.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_math: check_prelude_math.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_option: check_prelude_option.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_posix: check_prelude_posix.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_prelude_string: check_prelude_string.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_scripting: check_scripting.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_syntax: check_syntax.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

check_vision: check_vision.ml
	$(OCAMLC) -o $@ -linkpkg $(OCAMLCFLAGS) $<

EXTRA_DIST = check_common.ml

TESTS = $(check_PROGRAMS)

AM_DEFAULT_SOURCE_EXT = .ml

MOSTLYCLEANFILES = check_common.cmi check_common.cmo $(check_PROGRAMS:=.cmi) $(check_PROGRAMS:=.cmo)
