#!/usr/bin/env cram
# This is free and unencumbered software released into the public domain.

Environment:

  $ [ -n "$PYTHONPATH" ] || PYTHONPATH="$TESTDIR/../../priv/python" && export PYTHONPATH

Usage:

  $ $TESTDIR/../../src/libexec/opencv-objtrack -h
  usage: opencv-objtrack [-h] [-q | -v | -d] [-I [ID]] [-o [FILE]] [-a ALGO]
                         [-w]
                         [id]
  
  Driver for OpenCV object tracking.
  
  positional arguments:
    id                    the ID of the camera to attach to
  
  optional arguments:
    -h, --help            show this help message and exit
    -q, --quiet           suppress superfluous output
    -v, --verbose         increase the verbosity level
    -d, --debug           enable debugging output
    -I [ID], --id [ID]    set camera ID (default: default)
    -o [FILE], --output [FILE]
                          record output to MPEG-4 video file
    -a ALGO, --algorithm ALGO
                          set object-tracking algorithm (default: meanshift)
    -w, --window          show GUI window
