#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Test cases for the conreality.sdk.scripting module."""

from conreality.sdk.scripting import *

class TestContext:
  def test(self):
    assert True # TODO

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
