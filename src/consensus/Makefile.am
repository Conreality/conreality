# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

$(eval include $(top_srcdir)/src/Makefile.conf)

OCAMLCFLAGS  = $(AM_OCAMLCFLAGS)
OCAMLCFLAGS += -for-pack Consensus

include $(top_srcdir)/src/Makefile.rules

consensus_TARGETS = \
  consensus.cmi  \
  consensus.cmo  \
  consensus.cmx

consensus_INTERFACES = \
  prelude.cmi    \
  networking.cmi \
  syntax.cmi     \
  messaging.cmi  \
  scripting.cmi  \
  config.cmi     \
  geometry.cmi   \
  knowledge.cmi  \
  machinery.cmi  \
  measures.cmi   \
  model.cmi      \
  ontology.cmi   \
  physics.cmi    \
  vision.cmi

consensus_BYTECODE = \
  prelude.cmo    \
  networking.cmo \
  syntax.cmo     \
  messaging.cmo  \
  scripting.cmo  \
  config.cmo     \
  geometry.cmo   \
  knowledge.cmo  \
  machinery.cmo  \
  measures.cmo   \
  model.cmo      \
  ontology.cmo   \
  physics.cmo    \
  vision.cmo

consensus_OBJECTS = \
  prelude.cmx    \
  networking.cmx \
  syntax.cmx     \
  messaging.cmx  \
  scripting.cmx  \
  config.cmx     \
  geometry.cmx   \
  knowledge.cmx  \
  machinery.cmx  \
  measures.cmx   \
  model.cmx      \
  ontology.cmx   \
  physics.cmx    \
  vision.cmx

all-local: $(consensus_TARGETS)

syntax.cmi: syntax.mli syntax/token.mli

syntax.cmo syntax.cmx: syntax.ml syntax/lexer.ml syntax/parser.ml

syntax/parser.ml syntax/parser.mli: syntax/parser.mly
	$(MENHIR) --fixed-exception --external-tokens Token $<

consensus.cmi: $(consensus_INTERFACES)

consensus.cmo: $(consensus_BYTECODE)
	$(OCAMLC) -o $@ -pack $^

consensus.cmx: $(consensus_OBJECTS)
	$(OCAMLOPT) -o $@ -pack $^

MOSTLYCLEANFILES = $(consensus_TARGETS) $(consensus_INTERFACES) $(consensus_BYTECODE) $(consensus_OBJECTS)
CLEANFILES       = syntax/lexer.ml syntax/parser.ml syntax/parser.mli syntax/token.mli
