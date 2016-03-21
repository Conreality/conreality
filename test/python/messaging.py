#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Test cases for the conreality.sdk.messaging module."""

from conreality.sdk.messaging import *
from conreality.sdk.storage import DataDirectory
from inspect import *
import os

class TestTopicRegistry:
  """Test cases for the conreality.sdk.messaging.TopicRegistry class."""

  def test_construction_from_path(self):
    registry = TopicRegistry(path='/tmp')
    assert registry.path == '/tmp'

  def test_topics_generator(self):
    registry = TopicRegistry(path='/tmp')
    assert isgenerator(registry.topics())

class TestTopic:
  """Test cases for the conreality.sdk.messaging.Topic class."""

  def test_construction_from_path(self):
    topic = Topic(path='/tmp/foobar')
    assert topic.name == 'foobar'
    assert topic.path == '/tmp/foobar'
    assert topic.mode == 'r+'

  def test_construction_from_name(self):
    topic = Topic(name='foobar')
    assert topic.name == 'foobar'
    assert topic.path == os.path.join(DataDirectory.BASE_PATH, 'topics', 'foobar')
    assert topic.mode == 'r+'

class TestPublisher:
  """Test cases for the conreality.sdk.messaging.Publisher class."""

  def test_construction(self):
    publisher = Publisher(Topic(name='foobar'))
    assert publisher # TODO

class TestSubscriber:
  """Test cases for the conreality.sdk.messaging.Subscriber class."""

  def test_construction(self):
    subscriber = Subscriber(Topic(name='foobar'))
    assert subscriber # TODO

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
