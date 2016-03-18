#!/usr/bin/env cram
# This is free and unencumbered software released into the public domain.

Environment:

  $ [ -n "$PYTHONPATH" ] || PYTHONPATH="$TESTDIR/../../src/python" && export PYTHONPATH

Usage:

  $ $TESTDIR/../../src/libexec/opencv-camera -h
  Traceback (most recent call last):
    File "/home/arto/conreality/test/libexec/../../src/libexec/opencv-camera", line 7, in <module>
      import cv2
  ImportError: No module named 'cv2'
  [1]
