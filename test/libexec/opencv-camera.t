#!/usr/bin/env cram
# This is free and unencumbered software released into the public domain.

Environment:

  $ [ -n "$PYTHONPATH" ] || PYTHONPATH="$TESTDIR/../../priv/python" && export PYTHONPATH

Usage:

  $ $TESTDIR/../../src/libexec/opencv-camera -h
  usage: opencv-camera [-h] [-q | -v | -d] [-I [ID]] [-o [FILE]] [-w] [input]
  
  Driver for OpenCV video capture devices.
  
  positional arguments:
    input                 the video feed input (default: /dev/video0)
  
  optional arguments:
    -h, --help            show this help message and exit
    -q, --quiet           suppress superfluous output
    -v, --verbose         increase the verbosity level
    -d, --debug           enable debugging output
    -I [ID], --id [ID]    set camera ID (default: default)
    -o [FILE], --output [FILE]
                          record output to MPEG-4 video file
    -w, --window          show GUI window
