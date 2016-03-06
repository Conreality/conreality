# This is free and unencumbered software released into the public domain.

"""Camera support."""

from ..sdk.vision import SharedImage
from .driver import DataDirectory
import os

DATA_PATH      = 'cameras'
DEFAULT_WIDTH  = 640
DEFAULT_HEIGHT = 480

class CameraRegistry(DataDirectory):
  def __init__(self):
    super(CameraRegistry, self).__init__(DATA_PATH)
    self.refresh()

  def refresh(self):
    self.dirs = {}
    for id in os.listdir(self.path):
      if os.path.isdir(os.path.join(self.path, id)):
        self.dirs[id] = CameraDirectory(id)

  def __len__(self):
    return len(self.dirs)

  def __iter__(self):
    return iter(self.dirs.values())

  def __contains__(self, id):
    return id in self.dirs

  def __getitem__(self, id):
    return self.dirs[id]

class CameraDirectory(DataDirectory):
  def __init__(self, id):
    super(CameraDirectory, self).__init__(DATA_PATH, id)
    self.id = id

  def open_feed(self, **kwargs):
    if not 'mode' in kwargs:
      kwargs['mode'] = self.mode or 'r'
    if not 'width' in kwargs or not 'height' in kwargs:
      pass # TODO
    return CameraFeed(self, **kwargs)

class CameraFeed(object):
  def __init__(self, dir, width, height, format='bgr', mode='r'):
    self.path = os.path.join(dir.path, '{}x{}.{}'.format(width, height, format))
    self.image = SharedImage(self.path, width=width, height=height, format=format, mode=mode)

  def snap(self):
    return self.image.copy()
