# This is free and unencumbered software released into the public domain.

"""Video input/output."""

import cv2

class VideoEncoder:
  """Video encoder for writing MPEG-4 video files."""

  def __init__(self, filepath, size, fps=20, fourcc='FMP4'):
    self.fourcc = cv2.VideoWriter_fourcc(*fourcc)
    self.writer = cv2.VideoWriter(filepath, self.fourcc, fps, size, True)

  def is_open(self):
    return self.writer.isOpened()

  def is_closed(self):
    return not self.is_open()

  def close(self):
    self.writer.release()

  def write(self, frame):
    self.writer.write(frame.data)
