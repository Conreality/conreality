#!/usr/bin/env cram
# This is free and unencumbered software released into the public domain.

Environment:

  $ [ -n "$PYTHONPATH" ] || PYTHONPATH="$TESTDIR/../../src/python" && export PYTHONPATH

Usage:

  $ $TESTDIR/../../src/libexec/opencv-objtrack -h
  usage: opencv-objtrack [-h] [-q | -v | -d]
  
  Driver for ...
  
  optional arguments:
    -h, --help     show this help message and exit
    -q, --quiet    suppress superfluous output
    -v, --verbose  increase the verbosity level
    -d, --debug    enable debugging output
