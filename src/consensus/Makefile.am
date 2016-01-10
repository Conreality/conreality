# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

OCAMLC       = $(OCAMLFIND) ocamlc -verbose
OCAMLOPT     = $(OCAMLFIND) ocamlopt -verbose
OCAMLCFLAGS  = -pp $(CPPO) -thread
OCAMLCFLAGS += -package ctypes.foreign
OCAMLCFLAGS += -package irc-client.lwt
OCAMLCFLAGS += -package lua
OCAMLCFLAGS += -package lwt -package lwt.unix
OCAMLCFLAGS += -for-pack Consensus

consensus_TARGETS = \
  consensus.cmi  \
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

syntax.cmx: syntax.ml syntax/lexer.ml syntax/parser.ml

syntax/parser.ml: syntax/parser.mly
	$(MENHIR) --fixed-exception --external-tokens Token $<

syntax/parser.mli: syntax/parser.ml

consensus.cmi: $(consensus_INTERFACES)

consensus.cmx: $(consensus_OBJECTS)
	$(OCAMLOPT) -o $@ -pack $^

.ml.cmo:
	$(OCAMLC) -o $@ -c $(OCAMLCFLAGS) $<

.ml.cmx:
	$(OCAMLOPT) -o $@ -c $(OCAMLCFLAGS) $<

.ml.mli:
	$(OCAMLFIND) ocamlc -i $(OCAMLCFLAGS) $< > $@

.mli.cmi:
	$(OCAMLC) -o $@ -c $(OCAMLCFLAGS) $<

.mll.ml:
	$(OCAMLLEX) -o $@ -q $<

MOSTLYCLEANFILES = $(consensus_TARGETS) $(consensus_INTERFACES) $(consensus_OBJECTS)
CLEANFILES       = syntax/lexer.ml syntax/parser.ml syntax/parser.mli syntax/token.mli
