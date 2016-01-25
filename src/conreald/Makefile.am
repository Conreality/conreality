# See: https://www.gnu.org/software/automake/manual/html_node/A-Program.html
# See: https://www.gnu.org/software/automake/manual/html_node/Clean.html

include $(top_srcdir)/src/Makefile.flags

OCAMLCFLAGS  = $(AX_OCAMLCFLAGS)
OCAMLCFLAGS += -package cmdliner
OCAMLCFLAGS += -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/libconreality.a -cclib -Wl,--no-whole-archive

if ENABLE_COMPILE
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmx
else
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmo
endif

sbin_PROGRAMS = conreald

conreald_SOURCES = main.ml

$(eval include $(top_srcdir)/src/Makefile.conf)

conreald: $(conreald_SOURCES)
	$(OCAMLCOMPILE) -o $@ -linkpkg $(OCAMLCFLAGS) $^

MOSTLYCLEANFILES  =
MOSTLYCLEANFILES += $(conreald_SOURCES:.ml=.cmi)
MOSTLYCLEANFILES += $(conreald_SOURCES:.ml=.cmo)
MOSTLYCLEANFILES += $(conreald_SOURCES:.ml=.cmx)
