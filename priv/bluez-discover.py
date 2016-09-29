#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

try:
    import conreality
except ImportError:
    import os, sys
    sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), 'python')))
    import conreality

from conreality import otp as ddk
from conreality.ddk.sysexits import *

class Driver(ddk.Driver):
    """Driver for Bluetooth LE peripheral discovery (Linux only).

    requires the pydbus library for Python:
      $ sudo pip install pydbus
    """

    class ArgumentParser(ddk.ArgumentParser):
        def init(self):
            self.add_argument(
                '-i', '--adapter', nargs='?', default='hci0',
                help='specify local adapter interface (default: hci0)')

    def init(self):
        import bluez5
        self.adapter = bluez5.Adapter(self.options.adapter.strip())

    def run(self):
        for peripheral_address in self.adapter.peripherals():
            self.send(peripheral_address)
        return EX_OK

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
