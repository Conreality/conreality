# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

$(eval include $(top_srcdir)/src/Makefile.conf)

OCAMLCFLAGS  = $(AM_OCAMLCFLAGS)
OCAMLCFLAGS += -for-pack Consensus

include $(top_srcdir)/src/Makefile.rules

consensus_TARGETS = \
  consensus.cmi \
  consensus.cmo \
  consensus.cmx

consensus_MODULES = \
  prelude.ml    \
  networking.ml \
  syntax.ml     \
  messaging.ml  \
  scripting.ml  \
  config.ml     \
  geometry.ml   \
  knowledge.ml  \
  machinery.ml  \
  measures.ml   \
  model.ml      \
  ontology.ml   \
  physics.ml    \
  vision.ml

config.cmi:     $(wildcard config/*.mli)
config.cmo:     $(wildcard config/*.ml)
config.cmx:     $(wildcard config/*.ml)

geometry.cmi:   $(wildcard geometry/*.mli)
geometry.cmo:   $(wildcard geometry/*.ml)
geometry.cmx:   $(wildcard geometry/*.ml)

knowledge.cmi:  $(wildcard knowledge/*.mli)
knowledge.cmo:  $(wildcard knowledge/*.ml)
knowledge.cmx:  $(wildcard knowledge/*.ml)

machinery.cmi:  $(wildcard machinery/*.mli)
machinery.cmo:  $(wildcard machinery/*.ml)
machinery.cmx:  $(wildcard machinery/*.ml)

measures.cmi:   $(wildcard measures/*.mli)
measures.cmo:   $(wildcard measures/*.ml)
measures.cmx:   $(wildcard measures/*.ml)

messaging.cmi:  $(wildcard messaging/*.mli)
messaging.cmo:  $(wildcard messaging/*.ml)
messaging.cmx:  $(wildcard messaging/*.ml)

model.cmi:      $(wildcard model/*.mli)
model.cmo:      $(wildcard model/*.ml)
model.cmx:      $(wildcard model/*.ml)

networking.cmi: $(wildcard networking/*.mli)
networking.cmo: $(wildcard networking/*.ml)
networking.cmx: $(wildcard networking/*.ml)

ontology.cmi:   $(wildcard ontology/*.mli)
ontology.cmo:   $(wildcard ontology/*.ml)
ontology.cmx:   $(wildcard ontology/*.ml)

physics.cmi:    $(wildcard physics/*.mli)
physics.cmo:    $(wildcard physics/*.ml)
physics.cmx:    $(wildcard physics/*.ml)

prelude.cmi:    $(wildcard prelude/*.mli)
prelude.cmo:    $(wildcard prelude/*.ml)
prelude.cmx:    $(wildcard prelude/*.ml)

scripting.cmi:  $(wildcard scripting/*.mli)
scripting.cmo:  $(wildcard scripting/*.ml)
scripting.cmx:  $(wildcard scripting/*.ml)

syntax.cmi:     $(wildcard syntax/*.mli)
syntax.cmo:     $(wildcard syntax/*.ml)
syntax.cmx:     $(wildcard syntax/*.ml)

vision.cmi:     $(wildcard vision/*.mli)
vision.cmo:     $(wildcard vision/*.ml)
vision.cmx:     $(wildcard vision/*.ml)

consensus_INTERFACES = $(consensus_MODULES:.ml=.cmi)
consensus_BYTECODE   = $(consensus_MODULES:.ml=.cmo)
consensus_OBJECTS    = $(consensus_MODULES:.ml=.cmx)

all-local: $(consensus_TARGETS)

syntax.cmi: syntax.mli syntax/token.mli

syntax.cmo syntax.cmx: syntax.ml syntax/lexer.ml syntax/parser.ml

syntax/parser.ml syntax/parser.mli: syntax/parser.mly
	$(MENHIR) --fixed-exception --external-tokens Token $<

syntax/token.mli: syntax/token.ml
	$(OCAMLFIND) ocamlc -i $(OCAMLCFLAGS) $< > $@

consensus.cmi: $(consensus_INTERFACES)

consensus.cmo: $(consensus_BYTECODE)
	$(OCAMLC) -o $@ -pack $^

consensus.cmx: $(consensus_OBJECTS)
	$(OCAMLOPT) -o $@ -pack $^

EXTRA_DIST        = $(consensus_MODULES) $(consensus_MODULES:.ml=.mli)
MOSTLYCLEANFILES  = consensus.o
MOSTLYCLEANFILES += $(consensus_TARGETS)
MOSTLYCLEANFILES += $(consensus_INTERFACES)
MOSTLYCLEANFILES += $(consensus_BYTECODE)
MOSTLYCLEANFILES += $(consensus_OBJECTS)
MOSTLYCLEANFILES += $(consensus_MODULES:.ml=.o)
CLEANFILES        = syntax/lexer.ml syntax/parser.ml syntax/parser.mli syntax/token.mli
