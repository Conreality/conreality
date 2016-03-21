# This is free and unencumbered software released into the public domain.

"""Persistent storage."""

import os

try:
  from os import scandir
except ImportError:
  # See: https://pypi.python.org/pypi/scandir
  from scandir import scandir

class DataDirectoryException(OSError):
  def __init__(self, error):
    super(DataDirectoryException, self).__init__(error.errno, error.strerror, error.filename)

  def exit_code(self):
    return 73 # EX_CANTCREAT

class DataDirectory:
  BASE_PATH = '/tmp/var/run/conreality' # FIXME

  def __init__(self, *path):
    self.path = os.path.join(self.BASE_PATH, *path)

  def exists(self):
    return os.path.exists(self.path)

  def open(self, mode='r'):
    if mode != 'r' and not self.exists():
      try:
        os.makedirs(self.path, 0o777)
      except OSError as e:
        raise DataDirectoryException(e)
    self.mode = mode
    return self

  def close(self):
    self.mode = None

  def scan(self):
    return scandir(self.path)
