# This is free and unencumbered software released into the public domain.

"""Driver support."""

from ..sdk import scripting
from .sysexits import *
import argparse
import asyncio
import functools
import os
import select
import signal
import sys
import syslog

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

class Logger:
  def __enter__(self):
    return self

  def __exit__(self, *args):
    self.close()
    return False

  def open(self, verbosity=syslog.LOG_NOTICE):
    log_options = syslog.LOG_PID | syslog.LOG_CONS | syslog.LOG_NDELAY
    if self.options.debug:
      log_options |= syslog.LOG_PERROR
    syslog.openlog("conreality", logoption=log_options, facility=syslog.LOG_DAEMON)
    syslog.setlogmask(syslog.LOG_UPTO(verbosity))
    return self

  def close(self):
    syslog.closelog()

  def log(self, priority, message, *args):
    syslog.syslog(priority, message.format(*args))
    return self

  def panic(self, *args):
    return self.log(syslog.LOG_EMERG, *args)

  def alert(self, *args):
    return self.log(syslog.LOG_ALERT, *args)

  def critical(self, *args):
    return self.log(syslog.LOG_CRIT, *args)

  def error(self, *args):
    return self.log(syslog.LOG_ERR, *args)

  def warning(self, *args):
    return self.log(syslog.LOG_WARNING, *args)

  def notice(self, *args):
    return self.log(syslog.LOG_NOTICE, *args)

  def info(self, *args):
    return self.log(syslog.LOG_INFO, *args)

  def debug(self, *args):
    return self.log(syslog.LOG_DEBUG, *args)

class Program(Logger):
  """Base class for utility programs."""

  def __init__(self, argv=sys.argv, argparser=ArgumentParser, input=sys.stdin, output=sys.stdout):
    self.options = argparser().parse_args(argv[1:])
    self.input   = input
    self.output  = output
    Logger.open(self, verbosity=self.log_verbosity())

  def log_verbosity(self):
    if self.options.debug:
      return syslog.LOG_DEBUG
    if self.options.verbose:
      return syslog.LOG_INFO
    if self.options.quiet:
      return syslog.LOG_WARNING
    else:
      return syslog.LOG_NOTICE

class Driver(Program):
  """Base class for device drivers."""

  def __init__(self, argv=sys.argv, argparser=ArgumentParser, input=sys.stdin, output=sys.stdout):
    super(Driver, self).__init__(argv, argparser, input, output)
    self.__loop__ = asyncio.get_event_loop()
    self.__loop__.add_reader(self.input, self.handle_input)
    self.__sigs__ = {}
    self.catch_signal(signal.SIGHUP,  "SIGHUP")
    self.catch_signal(signal.SIGINT,  "SIGINT")
    self.catch_signal(signal.SIGPIPE, "SIGPIPE")
    self.catch_signal(signal.SIGTERM, "SIGTERM")
    self.context = scripting.Context()
    self.init()

  def __exit__(self, *args):
    for signum in self.__sigs__.keys():
      self.__loop__.remove_signal_handler(signum)
    self.exit()
    self.__loop__.close()
    return super(Driver, self).__exit__(*args)

  def init(self):
    pass # subclasses should override this

  def exit(self):
    pass # subclasses should override this

  def run(self):
    self.__loop__.call_soon(self.idle)
    self.__loop__.run_forever()
    return EX_OK

  def idle(self):
    self.loop()
    self.__loop__.call_soon(self.idle)

  def loop(self):
    pass # subclasses should override this

  def stop(self):
    self.__loop__.stop()

  def watch_readability(self, fd, callback, *args):
    self.__loop__.add_reader(fd, callback, *args)

  def watch_writability(self, fd, callback, *args):
    self.__loop__.add_writer(fd, callback, *args)

  def catch_signal(self, signum, name=None):
    self.__sigs__[signum] = name or signum
    self.__loop__.add_signal_handler(signum,
      functools.partial(self.handle_signal, signum))

  def handle_signal(self, signum):
    print("", file=sys.stderr)
    self.info("Received a {} signal ({}), terminating...", self.__sigs__[signum], signum)
    self.stop()
    # TODO: SignalException(signum).exit_code()

  def handle_input(self):
    input_line = self.input.readline()
    if not input_line:
      self.info("Received EOF on input, terminating...")
      self.stop()
      return
    self.debug("Read input command line: {}", repr(input_line))
    try:
      self.context.load_code(input_line)
    except scripting.Error as e:
      self.error("Failed to execute input command: {}", e)
