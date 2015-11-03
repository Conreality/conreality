Consensus Reality
=================

*"Don't panic, it's just a game."*

http://conreality.org

Prerequisites
-------------

* C/C++ compiler (e.g., GCC or Clang)
* OCaml compiler (>= 4.02)

Dependencies
------------

* `OpenCV <http://opencv.org/>`__

Installation
------------

Setting up the OCaml environment on Ubuntu 14.04 LTS (Trusty Tahr):

::

   $ sudo apt-add-repository ppa:avsm/ppa
   $ sudo apt-get update
   $ sudo apt-get install ocaml-nox opam
   $ opam init
   $ opam switch 4.02.3
   $ eval `opam config env`

General installation:

::

   $ git clone https://github.com/conreality/consensus.git
   $ cd consensus

   $ opam pin add consensus . --no-action --yes
   $ opam uninstall consensus           # not needed the first time around
   $ opam install consensus --verbose
   $ ocamlfind query consensus          # should print a path

