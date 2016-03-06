# This is free and unencumbered software released into the public domain.

"""Driver support."""

from __future__ import print_function
import argparse
import os
import signal
import sys
import syslog

EX_OK        = 0
EX_CANTCREAT = 73

class SignalException(Exception):
  def __init__(self, signum):
    self.signum = signum

  def exit_code(self):
    return 0x80 + self.signum

class DataDirectoryException(OSError):
  def __init__(self, error):
    super(DataDirectoryException, self).__init__(error.errno, error.strerror, error.filename)

  def exit_code(self):
    return EX_CANTCREAT

class ArgumentParser(argparse.ArgumentParser):
  def __init__(self):
    super(ArgumentParser, self).__init__()
    group = self.add_mutually_exclusive_group()
    group.add_argument('-q', '--quiet', action='store_true', help='suppress superfluous output')
    group.add_argument('-v', '--verbose', action='count', help='increase the verbosity level')
    group.add_argument('-d', '--debug', action='store_true', help='enable debugging output')
    self.init()

  def init(self):
    pass

class DataDirectory(object):
  BASE_PATH = '/tmp/var/run/conreality' # FIXME

  def __init__(self, *path):
    self.path = os.path.join(self.BASE_PATH, *path)

  def exists(self):
    return os.path.exists(self.path)

  def open(self, mode='r'):
    if mode != 'r' and not self.exists():
      try:
        os.makedirs(self.path, 0777)
      except OSError as e:
        raise DataDirectoryException(e)
    self.mode = mode
    return self

  def close(self):
    self.mode = None

class Driver(object):
  """Base class for device drivers."""

  def __init__(self, argv=sys.argv, argparser=ArgumentParser):
    self.options = argparser().parse_args(argv[1:])
    self.init()

  def init(self):
    pass

  def loop(self):
    self.pause()

  def run(self):
    try:
      self.open_log()
      self.init_signals()
      self.loop()
      return EX_OK
    except SignalException as e:
      print("", file=sys.stderr)
      self.info("Received a signal ({}), terminating...", e.signum)
      return e.exit_code()
    finally:
      self.exit()
      self.close_log()

  def pause(self):
    signal.pause()

  def open_log(self):
    log_options = syslog.LOG_PID | syslog.LOG_CONS | syslog.LOG_NDELAY
    if self.options.debug:
      log_options |= syslog.LOG_PERROR
    syslog.openlog("conreality", logoption=log_options, facility=syslog.LOG_DAEMON)
    syslog.setlogmask(syslog.LOG_UPTO(self.log_verbosity()))

  def close_log(self):
    syslog.closelog()

  def handle_signal(self, signum, stack_frame):
    raise SignalException(signum)

  def init_signals(self):
    signal.signal(signal.SIGHUP, self.handle_signal)
    signal.signal(signal.SIGINT, self.handle_signal)
    signal.signal(signal.SIGPIPE, self.handle_signal)
    signal.signal(signal.SIGTERM, self.handle_signal)

  def log_verbosity(self):
    if self.options.debug:
      return syslog.LOG_DEBUG
    if self.options.verbose:
      return syslog.LOG_INFO
    if self.options.quiet:
      return syslog.LOG_WARNING
    else:
      return syslog.LOG_NOTICE

  def log(self, priority, message, *args):
    syslog.syslog(priority, message.format(*args))

  def panic(self, *args):
    self.log(syslog.LOG_EMERG, *args)

  def alert(self, *args):
    self.log(syslog.LOG_ALERT, *args)

  def critical(self, *args):
    self.log(syslog.LOG_CRIT, *args)

  def error(self, *args):
    self.log(syslog.LOG_ERR, *args)

  def warning(self, *args):
    self.log(syslog.LOG_WARNING, *args)

  def notice(self, *args):
    self.log(syslog.LOG_NOTICE, *args)

  def info(self, *args):
    self.log(syslog.LOG_INFO, *args)

  def debug(self, *args):
    self.log(syslog.LOG_DEBUG, *args)
