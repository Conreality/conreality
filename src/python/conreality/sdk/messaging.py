# This is free and unencumbered software released into the public domain.

"""Messaging protocols."""

from .storage import DataDirectory
import os

DATA_PATH = 'topics'

class TopicRegistry(DataDirectory):
  """Topic registry."""

  def __init__(self, path=None):
    if path:
      self.path = path
    else:
      super(TopicRegistry, self).__init__(DATA_PATH)

  def topics(self):
    for entry in self.scan():
      if not entry.name.startswith('.') and entry.is_dir():
        yield Topic(path=os.path.join(self.path, entry.name))

class Topic(DataDirectory):
  """Topic exchange."""

  def __init__(self, path=None, name=None):
    if name:
      self.name = name
      super(Topic, self).__init__(DATA_PATH, name)
    elif path:
      self.name = os.path.basename(path)
      self.path = path
    else:
      raise ValueError("no topic name or path specified")
    self.open(mode='r+')

  def publish(self, message):
    return Publisher(self).send(message)

  def subscribe(self):
    return Subscriber(self)

class Publisher:
  """Message publisher."""

  def __init__(self, topic):
    self.topic = topic

  def send(self, message):
    pass # TODO

class Subscriber:
  """Message subscriber."""

  def __init__(self, topic):
    self.topic = topic

  def subscribe(self):
    pass # TODO

  def unsubscribe(self):
    pass # TODO
