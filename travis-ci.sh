# OCaml version to use
export OPAM_SWITCH=4.02.3
# OPAM version to install
export OPAM_VERSION=1.2.2
# OPAM packages needed to build tests
export OPAM_PACKAGES='alcotest'

# install ocaml from apt
sudo apt-get update -qq
sudo apt-get install -qq ocaml

# install opam
curl -L https://github.com/OCamlPro/opam/archive/${OPAM_VERSION}.tar.gz | tar xz -C /tmp
pushd /tmp/opam-${OPAM_VERSION}
./configure
make
sudo make install
opam init
eval `opam config -env`
opam switch ${OPAM_SWITCH}
eval `opam config -env`
popd

# install packages from opam
opam install -q -y ${OPAM_PACKAGES}

# compile & run tests
make clean && make check

# TODO: Run the benchmarks, too?

