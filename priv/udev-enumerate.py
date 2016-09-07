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
    """Driver for udev device enumeration (Linux only).

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
        if self.options.subsystem and self.options.devtype:
          self.devices = context.list_devices(
              subsystem=self.options.subsystem,
              DEVTYPE=self.options.devtype)
        elif self.options.subsystem:
          self.devices = context.list_devices(
              subsystem=self.options.subsystem)
        else:
          self.devices = context.list_devices()

    def run(self):
        for device in self.devices:
            if device.device_node:
                self.send((device.device_node, list(device.device_links)))
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
