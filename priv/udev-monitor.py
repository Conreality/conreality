#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

try:
    import conreality
except ImportError:
    import os, sys
    sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), 'python')))
    import conreality

from conreality import otp as ddk
from conreality.ddk.marshal import atom
from conreality.ddk.sysexits import *
from functools import partial

class Driver(ddk.Driver):
    """Driver for udev device monitoring (Linux only).

    requires the pyudev library for Python:
      $ sudo pip install pyudev
    """

    class ArgumentParser(ddk.ArgumentParser):
        def init(self):
            self.add_argument(
                'subsystem', nargs='?', default=None,
                help='the subsystem filter (e.g., input)')
            self.add_argument(
                'devtype', nargs='?', default=None,
                help='the device type filter')

    def init(self):
        import pyudev
        context = pyudev.Context()
        monitor = pyudev.Monitor.from_netlink(context)
        if self.options.subsystem:
            monitor.filter_by(self.options.subsystem, devtype=self.options.devtype)
        monitor.start()
        self.monitor = monitor
        self.watch_readability(self.monitor, self.poll)

    def exit(self):
        if self.monitor is not None:
            self.unwatch_readability(self.monitor)
            self.monitor = None

    def poll(self):
        for device in iter(partial(self.monitor.poll, 0), None):
            if device.device_node:
                self.send((atom(device.action), device.device_node, list(device.device_links)))

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
