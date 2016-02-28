# This is free and unencumbered software released into the public domain.

"""Vision algorithms."""

import numpy
import cv2

class Color(object):
  """A color."""

  def __init__(self, r, g, b):
    self.r = r
    self.g = g
    self.b = b

  def rgb(self):
    """Returns this color as an RGB tuple."""
    return (self.r, self.g, self.b)

  def bgr(self):
    """Returns this color as a BGR tuple (for OpenCV)."""
    return (self.b, self.g, self.r)

  def __repr__(self):
    """Returns a human-readable string representation of this color."""
    return "Color(r={}, g={}, b={})".format(self.r, self.g, self.b) # Python syntax

  def __str__(self):
    """Returns a human-readable string representation of this color."""
    return "color{{r={}, g={}, b={}}}".format(self.r, self.g, self.b) # Lua syntax

BLACK_COLOR = Color(0, 0, 0)
WHITE_COLOR = Color(255, 255, 255)
RED_COLOR   = Color(255, 0, 0)
GREEN_COLOR = Color(0, 255, 0)
BLUE_COLOR  = Color(0, 0, 255)

class Image(object):
  """An image."""

  def __init__(self, width, height, color=BLACK_COLOR):
    self.width  = width
    self.height = height
    if color == BLACK_COLOR:
      self.data = numpy.zeros((self.height, self.width, 3), numpy.uint8)
    elif color.r == color.g and color.r == color.b:
      self.data = numpy.full((self.height, self.width, 3), color.r, numpy.uint8)
    else:
      self.data = numpy.empty((self.height, self.width, 3), numpy.uint8)
      # TODO: initialize array with color
