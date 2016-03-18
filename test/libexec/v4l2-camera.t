#!/usr/bin/env cram
# This is free and unencumbered software released into the public domain.

Environment:

  $ [ -n "$PYTHONPATH" ] || PYTHONPATH="$TESTDIR/../../src/python" && export PYTHONPATH

Usage:

  $ $TESTDIR/../../src/libexec/v4l2-camera -h
  usage: v4l2-camera [-h] [-q | -v | -d] [-I [ID]] [camera]
  
  Driver for V4L2 video devices (Linux only).
  
  positional arguments:
    camera              the camera device (default: /dev/video0)
  
  optional arguments:
    -h, --help          show this help message and exit
    -q, --quiet         suppress superfluous output
    -v, --verbose       increase the verbosity level
    -d, --debug         enable debugging output
    -I [ID], --id [ID]  set camera ID (default: default)
