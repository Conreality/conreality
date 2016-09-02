#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

try:
    import conreality
except ImportError:
    import os, sys
    sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'src', 'python')))
    import conreality

from conreality import otp as ddk
from conreality.ddk.sysexits import EX_OK
import evdev

EVENT_TYPES = evdev.ecodes.EV
EVENT_CODES = evdev.ecodes.bytype

class Driver(ddk.Driver):
    """Driver for evdev input devices (Linux only)."""

    class ArgumentParser(ddk.ArgumentParser):
        def init(self):
            self.add_argument(
                'device', nargs=1, default=None,
                help='the input device (e.g., /dev/input/event4)')

    def init(self):
        self.device = evdev.InputDevice(self.options.device[0])

    def exit(self):
        if self.device is not None:
            self.device = None

    def run(self):
        for event in self.device.read_loop():
            event_type = EVENT_TYPES[event.type]
            event_code = EVENT_CODES[event.type][event.code]
            if isinstance(event_code, list):
              event_code = event_code[0]
            event_value = event.value
            #print((event_type, event_code, event_value)) # DEBUG
            self.send((self.atom(event_type), self.atom(event_code), event_value))
        return EX_OK

if __name__ == '__main__':
    import sys
    with Driver(argparser=Driver.ArgumentParser) as driver:
        sys.exit(driver.run())
