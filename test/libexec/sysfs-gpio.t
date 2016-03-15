Environment:

  $ [ -n "$PYTHONPATH" ] || PYTHONPATH="$TESTDIR/../../src/python" && export PYTHONPATH

Usage:

  $ $TESTDIR/../../src/libexec/sysfs-gpio -h
  usage: sysfs-gpio [-h] [-q | -v | -d] [-r] [-w] [-f [FREQ]] id
  
  Driver for GPIO pins (Linux only).
  
  positional arguments:
    id                    set the GPIO pin ID
  
  optional arguments:
    -h, --help            show this help message and exit
    -q, --quiet           suppress superfluous output
    -v, --verbose         increase the verbosity level
    -d, --debug           enable debugging output
    -r, --read            enable input on the GPIO pin
    -w, --write           enable output on the GPIO pin
    -f [FREQ], --freq [FREQ]
                          set polling frequency in Hz (default: max)
