include $(top_srcdir)/src/Makefile.flags

OCAMLCFLAGS  = $(AX_OCAMLCFLAGS)
OCAMLCFLAGS += -package cmdliner
OCAMLCFLAGS += -cclib -Wl,--whole-archive -cclib $(top_srcdir)/src/libconreality/libconreality.a -cclib -Wl,--no-whole-archive

if ENABLE_COMPILE
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmx
else
OCAMLCFLAGS += $(top_srcdir)/src/consensus/consensus.cmo
endif

pkglibexec_PROGRAMS = bcm283x

bcm283x_SOURCES = bcm2835.cmx servo.cmx main.ml

bcm2835.cmi: bcm2835.mli
	$(OCAMLC) -o $@ -c $<

mmap32.cmi: mmap32.mli
	$(OCAMLC) -o $@ -c $<

servo.cmi: servo.mli
	$(OCAMLC) -o $@ -c $<

time.cmi: time.mli
	$(OCAMLC) -o $@ -c $<

bcm2835.cmx: bcm2835.ml bcm2835.cmi mmap32.cmi time.cmi

servo.cmx: servo.ml bcm2835.cmi servo.cmi

$(eval include $(top_srcdir)/src/Makefile.conf)
include $(top_srcdir)/src/Makefile.rules

bcm283x: $(bcm283x_SOURCES)
	$(OCAMLCOMPILE) -o $@ -linkpkg $(OCAMLCFLAGS) $^

MOSTLYCLEANFILES  =
MOSTLYCLEANFILES += $(bcm283x_SOURCES:.ml=.cmi)
MOSTLYCLEANFILES += $(bcm283x_SOURCES:.ml=.cmo)
MOSTLYCLEANFILES += $(bcm283x_SOURCES:.ml=.cmx)
