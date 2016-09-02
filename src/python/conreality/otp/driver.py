# This is free and unencumbered software released into the public domain.

"""Erlang/OTP port driver support."""

from .sysexits import EX_OK
import argparse
import erlang
import os
import struct
import sys
import syslog

class SignalException(Exception):
    def __init__(self, signum):
        self.signum = signum

    def exit_code(self):
        return 0x80 + self.signum

class ArgumentParser(argparse.ArgumentParser):
    def __init__(self, description=None):
        super(ArgumentParser, self).__init__(description=description)
        group = self.add_mutually_exclusive_group()
        group.add_argument('-q', '--quiet', action='store_true', help='suppress superfluous output')
        group.add_argument('-v', '--verbose', action='count', help='increase the verbosity level')
        group.add_argument('-d', '--debug', action='store_true', help='enable debugging output')
        self.init()

    def init(self):
        pass

    def positive_int(self, string):
        value = int(string)
        if value <= 0:
            raise argparse.ArgumentTypeError("{} is not a positive integer".format(string))
        return value

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

    def __init__(self, argv=sys.argv, argparser=ArgumentParser):
        self.options = argparser(description=self.__doc__).parse_args(argv[1:])
        Logger.open(self, verbosity=self.log_verbosity)

    @property
    def log_verbosity(self):
        if self.options.debug:
            return syslog.LOG_DEBUG
        if self.options.verbose:
            return syslog.LOG_INFO
        if self.options.quiet:
            return syslog.LOG_WARNING
        else:
            return syslog.LOG_NOTICE

    @property
    def has_window(self):
        try:
            return self.options.window
        except AttributeError:
            return false

class Driver(Program):
    """Base class for device drivers."""

    def __init__(self, argv=sys.argv, argparser=ArgumentParser, input=None, output=None):
        super(Driver, self).__init__(argv, argparser)
        self.input = input or os.fdopen(3, 'rb')
        self.output = output or os.fdopen(4, 'wb')
        self.init()

    def __exit__(self, *args):
        # Terminate the event loop:
        self.exit()
        return super(Driver, self).__exit__(*args)

    def init(self):
        pass # subclasses should override this

    def exit(self):
        pass # subclasses should override this

    def run(self):
        pass # subclasses should override this
        return EX_OK

    def atom(self, str):
        return erlang.OtpErlangAtom(str)

    def send(self, term):
        """Write an Erlang term to an output stream."""
        stream = self.output
        payload = erlang.term_to_binary(term)
        header = struct.pack('!I', len(payload))
        stream.write(header)
        stream.write(payload)
        stream.flush()

    def recv(self):
        """Read an Erlang term from an input stream."""
        stream = self.input
        header = stream.read(4)
        if len(header) != 4:
            return None # EOF
        (length,) = struct.unpack('!I', header)
        payload = stream.read(length)
        if len(payload) != length:
            return None
        term = erlang.binary_to_term(payload)
        return term

    def recv_loop(self):
        """Yield Erlang terms from an input stream."""
        message = self.recv()
        while message:
            yield message
            message = self.recv()
