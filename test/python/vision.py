#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Test cases for the conreality.sdk.vision module."""

from conreality.sdk.vision import *

class TestColor:
  def test_positional_construction(self):
    color = Color(1, 2, 3)
    assert color.r == 1
    assert color.g == 2
    assert color.b == 3

  def test_keyword_construction(self):
    color = Color(r=1, g=2, b=3)
    assert color.r == 1
    assert color.g == 2
    assert color.b == 3

  def test_rgb_method(self):
    color = Color(1, 2, 3)
    assert color.rgb() == (1, 2, 3)

  def test_bgr_method(self):
    color = Color(1, 2, 3)
    assert color.bgr() == (3, 2, 1)

  def test_repr_result(self):
    color = Color(1, 2, 3)
    assert repr(color) == "Color(r=1, g=2, b=3)"

  def test_str_result(self):
    color = Color(1, 2, 3)
    assert str(color) == "color{r=1, g=2, b=3}"

class TestImage:
  def test(self):
    assert True # TODO

class TestSharedImage:
  def test(self):
    assert True # TODO

class TestCascadeClassifier:
  def test(self):
    assert True # TODO

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
