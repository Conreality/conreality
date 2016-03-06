# This is free and unencumbered software released into the public domain.

"""Camera support."""

from ..sdk.vision import SharedImage
from .driver import DataDirectory
import os

class CameraFeed(object):
  pass # TODO

class CameraDirectory(DataDirectory):
  def __init__(self, id):
    super(CameraDirectory, self).__init__('cameras', id)

  def open_image(self, width, height, mode='r+', format='bgr'):
    feed_name = '{}x{}.{}'.format(width, height, format)
    image_path = os.path.join(self.path, feed_name)
    return SharedImage(image_path, mode=mode, width=width, height=height)
