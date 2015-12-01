#!/bin/bash

# OCaml version to use
export OPAM_SWITCH=4.02.3
# OPAM version to install
export OPAM_VERSION=1.2.2
# OPAM packages needed to build tests
export OPAM_PACKAGES='alcotest bisect_ppx cmdliner cppo ctypes ctypes-foreign lwt ocaml-lua ocamlfind ocveralls'

# install OPAM and OCaml
sudo bash -c "echo 'APT::Default-Release \"wily\";' > /etc/apt/apt.conf.d/01ubuntu"
sudo bash -c "echo 'deb http://archive.ubuntu.com/ubuntu wily main restricted universe multiverse' >> /etc/apt/sources.list"
sudo bash -c "cat << EOF > /etc/apt/preferences
Package: opam
Pin: release n=wily
Pin-Priority: 900

Package: ocaml-nox
Pin: release n=wily
Pin-Priority: 900
EOF"
time sudo apt-get update -qq
time sudo apt-get install -qq -y opam ocaml-nox m4 libffi-dev liblua5.1-0-dev libopencv-dev

# set up the OPAM/OCaml environment with our desired OCaml version
time opam init -y
eval `opam config env`
time opam switch ${OPAM_SWITCH}
eval `opam config env`

# install packages from opam
time opam install -q -y ${OPAM_PACKAGES}

# compile & run tests with coverage instrumentation
time make clean && make check V=1

# generate Bisect coverage reports
#time make report V=1

# send code coverage report to Coveralls.io
#time ocveralls --prefix _build tmp/check/bisect00*.out --send
time ocveralls --prefix '' tmp/check/bisect00*.out --send
