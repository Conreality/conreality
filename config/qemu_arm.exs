# Configuration for the QEMU ARM target (qemu_arm).

use Mix.Config

config :conreality, platform: :qemu, arch: :arm, kernel: :linux

config :conreality, networking: [interface: :eth0, mode: "auto"]

config :conreality, status_leds: []
