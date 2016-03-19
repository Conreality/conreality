#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Test cases for the conreality.sdk.vision module."""

from conreality.sdk.vision import *

class TestColor:
  """Test cases for the conreality.sdk.vision.Color class."""

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
  """Test cases for the conreality.sdk.vision.Image class."""

  def test_construction_from_data(self):
    image_data = numpy.zeros((240, 320, 3), numpy.uint8)
    image = Image(data=image_data, format='bgr')
    assert image.width == 320
    assert image.height == 240
    assert image.is_bgr() # default format
    assert image.data is not None

  def test_construction_from_width_and_height(self):
    image = Image(width=320, height=240)
    assert image.width == 320
    assert image.height == 240
    assert image.is_bgr() # default format
    assert image.data is not None

  def test_dimensions_method(self):
    image = Image(width=320, height=240)
    assert image.dimensions() == (240, 320, 3)

  def test_to_bgr_method(self):
    image = Image(width=320, height=240)
    #assert image.to_bgr().is_bgr() # TODO: ImportError('cv2') on Ubuntu 14.04

class TestSharedImage:
  """Test cases for the conreality.sdk.vision.SharedImage class."""

  def test_construction(self):
    assert True # TODO

class TestCascadeClassifier:
  """Test cases for the conreality.sdk.vision.CascadeClassifier class."""

  def test_construction(self):
    assert True # TODO

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
