# See: https://www.gnu.org/software/automake/manual/html_node/A-Program.html
# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

$(eval include $(top_srcdir)/src/Makefile.conf)

OCAMLCFLAGS  = $(AX_OCAMLCFLAGS)
OCAMLCFLAGS += -package utop
OCAMLCFLAGS += -cclib -rdynamic -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/libconreality.a -cclib -Wl,--no-whole-archive
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmo

include $(top_srcdir)/src/Makefile.flags

bin_PROGRAMS = contop

contop_SOURCES = main.ml

contop: $(contop_SOURCES)
	$(OCAMLMKTOP) -o $@ -linkpkg $(OCAMLCFLAGS) $^

MOSTLYCLEANFILES  =
MOSTLYCLEANFILES += $(contop_SOURCES:.ml=.cmi)
MOSTLYCLEANFILES += $(contop_SOURCES:.ml=.cmo)
