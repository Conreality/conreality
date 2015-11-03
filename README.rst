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

::

   $ git clone https://github.com/conreality/consensus.git
   $ cd consensus

   $ opam pin add consensus . --no-action --yes
   $ opam uninstall consensus           # not needed the first time around
   $ opam install consensus --verbose
   $ ocamlfind query consensus          # should print a path
