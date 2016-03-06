# This is free and unencumbered software released into the public domain.

"""Camera support."""

from ..sdk.vision import SharedImage
from .driver import DataDirectory
import os

class CameraFeed(object):
  def __init__(self, dir, width, height, format='bgr', mode='r'):
    self.path = os.path.join(dir.path, '{}x{}.{}'.format(width, height, format))
    self.image = SharedImage(self.path, width=width, height=height, format=format, mode=mode)

  def snap(self):
    return self.image.copy()

class CameraDirectory(DataDirectory):
  def __init__(self, id):
    super(CameraDirectory, self).__init__('cameras', id)

  def open_feed(self, **kwargs):
    if not 'mode' in kwargs:
      kwargs['mode'] = self.mode or 'r'
    return CameraFeed(self, **kwargs)

class CameraRegistry(object):
  pass # TODO
