#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Test cases for the conreality.sdk.messaging module."""

from asyncio import Future
from conreality.sdk.messaging import *
from conreality.sdk.storage import DataDirectory
from inspect import *
from time import sleep
import os

class TestTopicRegistry:
  """Test cases for the conreality.sdk.messaging.TopicRegistry class."""

  def test_construction_from_path(self, tmpdir):
    registry = TopicRegistry(path=tmpdir)
    assert registry.path == str(tmpdir)

  def test_topics_generator(self, tmpdir):
    registry = TopicRegistry(path=tmpdir)
    assert isgenerator(registry.topics())

class TestTopic:
  """Test cases for the conreality.sdk.messaging.Topic class."""

  def test_construction_from_path(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    assert topic.name == 'foobar'
    assert topic.path == os.path.join(str(tmpdir), 'foobar')
    assert topic.mode == 'r+'

  def test_construction_from_name(self, tmpdir):
    DataDirectory.BASE_PATH = str(tmpdir)
    topic = Topic(name='foobar')
    assert topic.name == 'foobar'
    assert topic.path == os.path.join(DataDirectory.BASE_PATH, 'topics', 'foobar')
    assert topic.mode == 'r+'

  def test_subscribers_generator(self):
    topic = Topic(name='foobar')
    assert isgenerator(topic.subscribers())

class TestSubscriber:
  """Test cases for the conreality.sdk.messaging.Subscriber class."""

  def test_construction(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    with Subscriber(topic) as subscriber:
      assert subscriber.topic == topic
      assert type(subscriber.id) is int
      assert subscriber.path == str(tmpdir.join('foobar', str(subscriber.id)))
      assert subscriber.fd is not None

class TestPublisher:
  """Test cases for the conreality.sdk.messaging.Publisher class."""

  class SubscriberThread(threading.Thread):
    def __init__(self, topic, id):
      super().__init__(target=self)
      self.subscriber = Subscriber(topic=topic, id=id)
      self.future = Future()
    def done(self):
      return self.future.done()
    def result(self):
      return self.future.result()
    def run(self):
      try:
        self.subscriber.open()
        result = self.subscriber.receive() # blocks until message arrival
        self.subscriber.close()
        self.future.set_result(result)
      except Exception as error:
        self.future.set_exception(error)

  def test_construction(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    with Publisher(topic) as publisher:
      assert publisher.topic == topic

  def test_publish_with_no_subscribers(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message = "Hello, world!"
    with Publisher(topic) as publisher:
      assert publisher.publish(message) == set()

  def test_publish_with_one_subscriber(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message = "Hello, world!"
    with Publisher(topic) as publisher:
      thread = self.SubscriberThread(topic, 1)
      thread.start()
      sleep(0.25)    # wait for subscribers
      assert publisher.publish(message) == set((1,))
      thread.join()  # wait for subscribers
      assert thread.done()
      assert thread.result() == message

  def test_publish_with_two_subscribers(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message = "Hello, world!"
    with Publisher(topic) as publisher:
      thread1 = self.SubscriberThread(topic, 1)
      thread1.start()
      thread2 = self.SubscriberThread(topic, 2)
      thread2.start()
      sleep(0.25)    # wait for subscribers
      assert publisher.publish(message) == set((1, 2))
      thread1.join() # wait for subscribers
      assert thread1.done()
      assert thread1.result() == message
      thread2.join() # wait for subscribers
      assert thread2.done()
      assert thread2.result() == message

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
