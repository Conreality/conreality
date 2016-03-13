include $(top_srcdir)/src/Makefile.flags

OCAMLCFLAGS  = $(AX_OCAMLCFLAGS)
OCAMLCFLAGS += -package cmdliner
OCAMLCFLAGS += -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/libconreality.a -cclib -Wl,--no-whole-archive

if ENABLE_COMPILE
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmx
else
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmo
endif

bin_PROGRAMS = bcm283x

bcm283x_SOURCES = main.ml servo.ml

$(eval include $(top_srcdir)/src/Makefile.conf)

bcm283x: $(bcm283x_SOURCES)
	$(OCAMLCOMPILE) -o $@ -linkpkg $(OCAMLCFLAGS) $^

MOSTLYCLEANFILES  =
MOSTLYCLEANFILES += $(bcm283x_SOURCES:.ml=.cmi)
MOSTLYCLEANFILES += $(bcm283x_SOURCES:.ml=.cmo)
MOSTLYCLEANFILES += $(bcm283x_SOURCES:.ml=.cmx)
