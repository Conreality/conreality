Consensus Reality
=================

*"Don't panic, it's just a game."*

http://conreality.org

Prerequisites
-------------

To build the development version from a Git checkout, you will need a POSIX
system and the following tooling:

* OCaml compiler (>= 4.02.1)
  with `Findlib <http://projects.camlcity.org/projects/findlib.html>`__
* C/C++ compiler (GCC >= 4.8 or Clang >= 3.4)
* GNU Make

Dependencies
------------

* `libffi <https://sourceware.org/libffi/>`__ (>= 3.0.13)

* `OpenCV <http://opencv.org/>`__ (>= 2.4)

* `Ctypes <https://github.com/ocamllabs/ocaml-ctypes>`__

On Debian or Ubuntu, install the needed native runtime libraries and header
files as follows::

   $ sudo apt-get install libffi-dev libopencv-dev

Installation
------------

Prerequisites for Ubuntu 14.04 LTS (Trusty Tahr)::

   $ sudo apt-add-repository ppa:avsm/ppa
   $ sudo apt-get update
   $ sudo apt-get install ocaml-nox opam

Prerequisites for Raspberry Pi running Raspbian/Jessie::

   $ sudo apt-get install ocaml-nox m4
   $ git clone https://github.com/ocaml/opam.git
   $ cd opam
   $ git checkout 1.2
   $ ./configure
   $ make lib-ext
   $ make
   $ sudo make install
   $ cd ..

General initialization of local OCaml environment::

   $ opam init
   $ eval `opam config env`
   $ opam switch 4.02.3
   $ eval `opam config env`

General local installation procedure using the `OPAM <opam.ocaml.org>`__
package manager::

   $ git clone --recursive https://github.com/conreality/consensus.git
   $ cd consensus

   $ opam pin add consensus . --no-action --yes
   $ opam uninstall consensus           # not needed the first time around
   $ opam install consensus --verbose
   $ ocamlfind query consensus          # should print a path

