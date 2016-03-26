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
        result = self.loop()
        self.future.set_result(result)
      except Exception as error:
        self.future.set_exception(error)
      finally:
        self.subscriber.close()
    def loop(self):
      raise NotImplementedError()

  class SingleMessageSubscriberThread(SubscriberThread):
    def loop(self):
      return self.subscriber.receive() # blocks until message arrival

  class MultiMessageSubscriberThread(SubscriberThread):
    def __init__(self, topic, id, count=1):
      super().__init__(topic=topic, id=id)
      self.count = count
    def loop(self):
      result = []
      while self.count:
        result.append(self.subscriber.receive()) # blocks until message arrival
        self.count -= 1
      return tuple(result)

  def test_construction(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    with Publisher(topic) as publisher:
      assert publisher.topic == topic

  def test_publish_with_no_subscribers(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message = "Hello, world!"
    with Publisher(topic) as publisher:
      assert publisher.publish(message) == set()

  def test_publish_a_message_to_one_subscriber(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message = "Hello, world!"
    with Publisher(topic) as publisher:
      thread = self.SingleMessageSubscriberThread(topic, 1)
      thread.start()
      sleep(0.25)    # wait for subscribers
      assert publisher.publish(message) == set((1,))
      thread.join()  # wait for subscribers
      assert thread.done()
      assert isinstance(thread.result(), Message)
      assert thread.result().decode() == message

  def test_publish_a_message_to_two_subscribers(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message = "Hello, world!"
    with Publisher(topic) as publisher:
      thread1 = self.SingleMessageSubscriberThread(topic, 1)
      thread1.start()
      thread2 = self.SingleMessageSubscriberThread(topic, 2)
      thread2.start()
      sleep(0.25)    # wait for subscribers
      assert publisher.publish(message) == set((1, 2))
      thread1.join() # wait for subscribers
      assert thread1.done()
      assert isinstance(thread1.result(), Message)
      assert thread1.result().decode() == message
      thread2.join() # wait for subscribers
      assert thread2.done()
      assert isinstance(thread2.result(), Message)
      assert thread2.result().decode() == message

  def test_publish_two_messages_to_one_subscriber(self, tmpdir):
    topic = Topic(path=tmpdir.join('foobar'))
    message1, message2 = "Hello, ", "world!"
    with Publisher(topic) as publisher:
      thread = self.MultiMessageSubscriberThread(topic, 1, 2)
      thread.start()
      sleep(0.25)    # wait for subscribers
      assert publisher.publish(message1) == set((1,))
      sleep(0.25)    # wait for subscribers
      assert publisher.publish(message2) == set((1,))
      thread.join()  # wait for subscribers
      assert thread.done()
      assert isinstance(thread.result(), tuple)
      result1, result2 = thread.result()
      assert isinstance(result1, Message)
      assert result1.decode() == message1
      assert isinstance(result2, Message)
      assert result2.decode() == message2

if __name__ == '__main__':
  import pytest, sys
  sys.exit(pytest.main(__file__))
