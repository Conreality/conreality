# Configuration for the Raspberry Pi 2 target (rpi2).

use Mix.Config

config :conreality, platform: :rpi2, arch: :arm, kernel: :linux

config :conreality, networking: [interface: :eth0, mode: "auto"]

config :conreality, status_leds: [:red, :green]

config :nerves_leds, names: [red: "led0", green: "led1"]
