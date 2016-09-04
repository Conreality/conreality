#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

try:
    import conreality
except ImportError:
    import os, sys
    sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'src', 'python')))
    import conreality

from conreality import otp as ddk
from conreality.ddk.marshal import atom
from conreality.ddk.sysexits import *

class Driver(ddk.Driver):
    """Driver for sending pings on a specified interval."""

    class ArgumentParser(ddk.ArgumentParser):
        def init(self):
            self.add_argument(
                'interval', nargs='?', type=float, default=1.0,
                help="set the sleep interval")

    def init(self):
        self.interval = self.options.interval
        self.__loop__.call_later(self.interval, self.ping)

    def exit(self):
        pass

    def ping(self):
        self.send(atom('ping'))
        self.__loop__.call_later(self.interval, self.ping)

if __name__ == '__main__':
    import sys
    try:
        with Driver(argparser=Driver.ArgumentParser) as driver:
            sys.exit(driver.run())
    except ImportError as error:
        print(error, file=sys.stderr)
        sys.exit(EX_UNAVAILABLE)
    except FileNotFoundError as error:
        print(error, file=sys.stderr)
        sys.exit(EX_NOINPUT)
    except PermissionError as error:
        print(error, file=sys.stderr)
        sys.exit(EX_NOINPUT)
