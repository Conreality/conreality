#!/bin/bash -e

opam uninstall consensus
opam pin remove consensus
opam pin add consensus . --no-action --yes
opam install consensus --verbose
ocamlfind query consensus
