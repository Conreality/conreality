# This is free and unencumbered software released into the public domain.

"""Vision algorithms."""

import numpy
import cv2

class Color(object):
  """A red-green-blue (RGB) color value."""

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

  def gray(self):
    """Returns this color as a grayscale scalar (for OpenCV)."""
    gray_array = cv2.cvtColor(numpy.uint8([[list(self.bgr())]]), cv2.COLOR_BGR2GRAY)
    return gray_array[0][0]

  def hsv(self):
    """Returns this color as an HSV tuple (for OpenCV)."""
    hsv_array = cv2.cvtColor(numpy.uint8([[list(self.bgr())]]), cv2.COLOR_BGR2HSV)
    return tuple(hsv_array[0][0])

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
  """A two-dimensional (2D) image."""

  def __init__(self, width=None, height=None, color=BLACK_COLOR, data=None, format='bgr'):
    if data is not None:
      self.height, self.width, _ = data.shape
      self.data = data
      self.format = format
    else:
      self.width = width
      self.height = height
      if color == BLACK_COLOR:
        self.data = numpy.zeros((height, width, 3), numpy.uint8)
      elif color.r == color.g and color.r == color.b:
        self.data = numpy.full((height, width, 3), color.r, numpy.uint8)
      else:
        self.data = numpy.empty((height, width, 3), numpy.uint8)
        cv2.rectangle(self.data, (0, 0), (width-1, height-1), color.bgr(), cv2.cv.CV_FILLED)
      self.format = format

  def is_bgr(self):
    """Determines whether this is a BGR image."""
    return self.format == 'bgr'

  def is_gray(self):
    """Determines whether this is a grayscale image."""
    return self.format == 'gray'

  def is_hsv(self):
    """Determines whether this is an HSV image."""
    return self.format == 'hsv'

  def copy(self):
    """Returns a new copy of this image."""
    return Image(data=self.data.copy())

  def copy_from(self, image):
    """Overwrites this image with the data from the given same-shaped image."""
    numpy.copyto(self.data, image.data, 'no')

  def copy_to(self, image):
    """Overwrites the given same-shaped image with the data from this image."""
    numpy.copyto(image.data, self.data, 'no')

  def data_as_gray(self):
    return cv2.cvtColor(self.data, cv2.COLOR_BGR2GRAY)

  def data_as_hsv(self):
    return cv2.cvtColor(self.data, cv2.COLOR_BGR2HSV)

  def to_gray(self):
    return Image(data=self.data_as_gray())

  def to_hsv(self):
    return Image(data=self.data_as_hsv())

  def histogram(self):
    """Returns a normalized HSV histogram of this image."""
    data = self.data_as_hsv()
    mask = cv2.inRange(data, numpy.array((0., 60., 32.)), numpy.array((180., 255., 255.)))
    hist = cv2.calcHist([data], [0], mask, [180], [0, 180])
    cv2.normalize(hist, hist, 0, 255, cv2.NORM_MINMAX)
    return hist

  def draw_circle(self, center, radius, color, thickness=1):
    cv2.circle(self.data, center, radius, color.bgr(), thickness)
    return self

  def draw_line(self, point1, point2, color, thickness=1):
    cv2.line(self.data, point1, point2, color.bgr(), thickness)
    return self

  def draw_polylines(self, points, is_closed, color, thickness=1):
    cv2.polylines(self.data, points, is_closed, color.bgr(), thickness)
    return self

  def draw_rectangle(self, point1, point2, color, thickness=1):
    cv2.rectangle(self.data, point1, point2, color.bgr(), thickness)
    return self

  def draw(self, shape):
    return self # TODO

class SharedImage(Image):
  """A two-dimensional (2D) image in shared memory."""

  def __init__(self, pathname, mode='r', width=None, height=None, format='bgr'):
    self.pathname = pathname
    self.width = width
    self.height = height
    self.format = format
    self.data = numpy.memmap(pathname, numpy.uint8, mode, offset=0, shape=(height, width, 3))

  @property
  def mode(self):
    return self.data.mode

  @property
  def offset(self):
    return self.data.offset

  def flush(self):
    """Write back any changes in the image to the backing storage."""
    self.data.flush()
