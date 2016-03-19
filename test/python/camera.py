#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Test cases for the conreality.ddk.camera module."""

from conreality.ddk.camera import *

class TestCameraRegistry:
  """Test cases for the conreality.ddk.camera.CameraRegistry class."""

  def test_construction(self):
    assert True # TODO

class TestCameraDirectory:
  """Test cases for the conreality.ddk.camera.CameraDirectory class."""

  def test_construction(self):
    assert True # TODO

class TestCameraFeed:
  """Test cases for the conreality.ddk.camera.CameraFeed class."""

  def test_construction(self):
    assert True # TODO

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
