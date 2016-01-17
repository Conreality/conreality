# See: https://www.gnu.org/software/automake/manual/html_node/A-Program.html
# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

$(eval include $(top_srcdir)/src/Makefile.conf)

OCAMLCFLAGS  = $(AX_OCAMLCFLAGS)
OCAMLCFLAGS += -package cmdliner
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmx
OCAMLCFLAGS += -cclib -rdynamic -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/libconreality.a -cclib -Wl,--no-whole-archive

bin_PROGRAMS = conctl

conctl_SOURCES = main.ml

conctl: $(conctl_SOURCES)
	$(OCAMLOPT) -o $@ -linkpkg $(OCAMLCFLAGS) $^

MOSTLYCLEANFILES  =
MOSTLYCLEANFILES += $(conctl_SOURCES:.ml=.cmi)
MOSTLYCLEANFILES += $(conctl_SOURCES:.ml=.cmo)
MOSTLYCLEANFILES += $(conctl_SOURCES:.ml=.cmx)
