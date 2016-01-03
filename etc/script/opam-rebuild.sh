#!/bin/bash -e

export OPAMSOLVERTIMEOUT=30
opam uninstall consensus || true
opam pin remove consensus
opam pin add consensus . --no-action --yes
time opam install consensus --verbose
ocamlfind query consensus
