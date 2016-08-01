# Configuration for the BeagleBone Black target (bbb).

use Mix.Config

config :conreality, platform: :bbb, arch: :arm, kernel: :linux

config :conreality, networking: [interface: :eth0, mode: "auto"]

config :conreality, status_leds: [:led0, :led1, :led2, :led3]

config :nerves_leds, names: [
  led0: "beaglebone:green:usr0",
  led1: "beaglebone:green:usr1",
  led2: "beaglebone:green:usr2",
  led3: "beaglebone:green:usr3",
]
