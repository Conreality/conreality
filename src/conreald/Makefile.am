# See: https://www.gnu.org/software/automake/manual/html_node/A-Program.html
# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

$(eval include $(top_srcdir)/src/Makefile.conf)

OCAMLCFLAGS  = $(AM_OCAMLCFLAGS)
OCAMLCFLAGS += -package cmdliner
OCAMLCFLAGS += -I $(top_srcdir)/src/consensus $(top_srcdir)/src/consensus/consensus.cmx
OCAMLCFLAGS += -cclib -rdynamic -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/.libs/libconreality.a -cclib -Wl,--no-whole-archive

bin_PROGRAMS = conreald

conreald_SOURCES = main.ml

conreald: $(conreald_SOURCES)
	$(OCAMLOPT) -o $@ -linkpkg $(OCAMLCFLAGS) $^

MOSTLYCLEANFILES  =
MOSTLYCLEANFILES += $(conreald_SOURCES:.ml=.cmi)
MOSTLYCLEANFILES += $(conreald_SOURCES:.ml=.cmo)
MOSTLYCLEANFILES += $(conreald_SOURCES:.ml=.cmx)
