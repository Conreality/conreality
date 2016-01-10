# See: https://www.gnu.org/software/automake/manual/html_node/A-Program.html
# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

OCAMLC       = $(OCAMLFIND) ocamlc -verbose
OCAMLOPT     = $(OCAMLFIND) ocamlopt -verbose
OCAMLCFLAGS  = -pp $(CPPO) -thread
OCAMLCFLAGS += -cclib -rdynamic -cclib -Wl,--whole-archive -cclib ../libconreality/libconreality.a -cclib -Wl,--no-whole-archive
OCAMLCFLAGS += -I ../consensus ../consensus/consensus.cmx
OCAMLCFLAGS += -package cmdliner
OCAMLCFLAGS += -package ctypes.foreign
OCAMLCFLAGS += -package irc-client.lwt
OCAMLCFLAGS += -package lua
OCAMLCFLAGS += -package lwt -package lwt.unix

bin_PROGRAMS = conctl

conctl_SOURCES = conctl.ml

conctl: $(conctl_SOURCES)
	$(OCAMLOPT) -o $@ -linkpkg $(OCAMLCFLAGS) $^
