# This is free and unencumbered software released into the public domain.

"""Vision algorithms."""

import errno
import numpy
import os

class Color:
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
    import cv2
    gray_array = cv2.cvtColor(numpy.uint8([[list(self.bgr())]]), cv2.COLOR_BGR2GRAY)
    return gray_array[0][0]

  def hsv(self):
    """Returns this color as an HSV tuple (for OpenCV)."""
    import cv2
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

class Image:
  """A two-dimensional (2D) image."""

  def __init__(self, width=None, height=None, color=BLACK_COLOR, data=None, format='bgr'):
    if data is not None:
      self.format = format
      self.height, self.width = data.shape[0:2]
      self.data = data
    else:
      self.format = format
      self.width = width
      self.height = height
      if color == BLACK_COLOR:
        self.data = numpy.zeros(self.dimensions(), numpy.uint8)
      elif color.r == color.g and color.r == color.b:
        self.data = numpy.full(self.dimensions(), color.r, numpy.uint8)
      else:
        import cv2
        self.data = numpy.empty(self.dimensions(), numpy.uint8)
        cv2.rectangle(self.data, (0, 0), (width-1, height-1), color.bgr(), cv2.cv.CV_FILLED)

  def is_bgr(self):
    """Determines whether this is a BGR image."""
    return self.format == 'bgr'

  def is_gray(self):
    """Determines whether this is a grayscale image."""
    return self.format == 'gray'

  def is_hsv(self):
    """Determines whether this is an HSV image."""
    return self.format == 'hsv'

  # @see http://www.fourcc.org/yuv.php#YUYV
  def is_yuyv(self):
    """Determines whether this is an YUV 4:2:2 (aka YUYV, YUY2) image."""
    return self.format == 'yuyv'

  @property
  def size(self):
    return (self.width, self.height)

  def dimensions(self):
    if self.is_bgr() or self.is_hsv():
      return (self.height, self.width, 3)
    if self.is_gray():
      return (self.height, self.width, 1)
    if self.is_yuyv():
      return (self.height, self.width, 2)
    assert False

  def copy(self):
    """Returns a new copy of this image."""
    return Image(data=self.data.copy(), format=self.format)

  def copy_from(self, image):
    """Overwrites this image with the data from the given same-shaped image."""
    numpy.copyto(self.data, image.data, 'no')

  def copy_to(self, image):
    """Overwrites the given same-shaped image with the data from this image."""
    numpy.copyto(image.data, self.data, 'no')

  def data_as_bgr(self):
    import cv2
    if self.is_bgr():
      return self.data
    if self.is_gray():
      return cv2.cvtColor(self.data, cv2.COLOR_GRAY2BGR)
    if self.is_hsv():
      return cv2.cvtColor(self.data, cv2.COLOR_HSV2BGR)
    if self.is_yuyv():
      return cv2.cvtColor(self.data, cv2.COLOR_YUV2BGR_YUYV)
    assert False

  def data_as_gray(self):
    import cv2
    if self.is_bgr():
      return cv2.cvtColor(self.data, cv2.COLOR_BGR2GRAY)
    if self.is_gray():
      return self.data
    if self.is_hsv():
      return cv2.cvtColor(self.data_as_bgr(), cv2.COLOR_BGR2GRAY)
    if self.is_yuyv():
      return cv2.cvtColor(self.data, cv2.COLOR_YUV2GRAY_YUYV)
    assert False

  def data_as_hsv(self):
    import cv2
    if self.is_bgr():
      return cv2.cvtColor(self.data, cv2.COLOR_BGR2HSV)
    if self.is_gray():
      return cv2.cvtColor(self.data_as_bgr(), cv2.COLOR_BGR2HSV)
    if self.is_hsv():
      return self.data
    if self.is_yuyv():
      return cv2.cvtColor(self.data_as_bgr(), cv2.COLOR_BGR2HSV)
    assert False

  def to_bgr(self):
    return Image(data=self.data_as_bgr(), format='bgr')

  def to_gray(self):
    return Image(data=self.data_as_gray(), format='gray')

  def to_hsv(self):
    return Image(data=self.data_as_hsv(), format='hsv')

  def histogram(self):
    """Returns a normalized HSV histogram of this image."""
    import cv2
    data = self.data_as_hsv()
    mask = cv2.inRange(data, numpy.array((0., 60., 32.)), numpy.array((180., 255., 255.)))
    hist = cv2.calcHist([data], [0], mask, [180], [0, 180])
    cv2.normalize(hist, hist, 0, 255, cv2.NORM_MINMAX)
    return hist

  def draw_circle(self, center, radius, color, thickness=1):
    import cv2
    cv2.circle(self.data, center, radius, color.bgr(), thickness)
    return self

  def draw_line(self, point1, point2, color, thickness=1):
    import cv2
    cv2.line(self.data, point1, point2, color.bgr(), thickness)
    return self

  def draw_polylines(self, points, is_closed, color, thickness=1):
    import cv2
    cv2.polylines(self.data, points, is_closed, color.bgr(), thickness)
    return self

  def draw_rectangle(self, point1, point2, color, thickness=1):
    import cv2
    cv2.rectangle(self.data, point1, point2, color.bgr(), thickness)
    return self

  def draw_text(self, origin, text, color, thickness=1):
    import cv2
    font_face, font_scale = cv2.FONT_HERSHEY_PLAIN, 1
    (text_width, text_height), baseline = cv2.getTextSize(text, font_face, font_scale, thickness)
    (origin_x, origin_y) = origin
    if origin_x < 0:
      origin_x = self.width + origin_x - text_width
    if origin_y < 0:
      origin_y = self.height + origin_y
    cv2.putText(self.data, text, (origin_x, origin_y), font_face, font_scale, color.bgr(), thickness)
    return self

  def draw(self, shape):
    return self # TODO

class SharedImage(Image):
  """A two-dimensional (2D) image in shared memory."""

  def __init__(self, pathname, width=None, height=None, format='bgr', mode='r'):
    self.pathname = pathname
    self.format = format
    self.width = width
    self.height = height
    self.data = numpy.memmap(pathname, numpy.uint8, mode, offset=0, shape=self.dimensions())

  @property
  def mode(self):
    return self.data.mode

  @property
  def offset(self):
    return self.data.offset

  def flush(self):
    """Write back any changes in the image to the backing storage."""
    self.data.flush()

class CascadeClassifier:
  @staticmethod
  def find(filename):
    return '/opt/local/share/OpenCV/haarcascades/' + filename # FIXME

  def __init__(self, filename):
    import cv2
    self.classifier = cv2.CascadeClassifier(self.find(filename))
    if self.classifier.empty():
      raise OSError(errno.ENOENT, os.strerror(errno.ENOENT), filename)

  def detect(self, image, *args):
    result = []
    for (x, y, w, h) in self.classifier.detectMultiScale(image.data, *args):
      result.append((x, y, w, h))
    return result
