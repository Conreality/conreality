# Configuration for the Raspberry Pi 3 target (rpi3).

use Mix.Config

config :conreality, platform: :rpi3, arch: :arm, kernel: :linux

config :conreality, networking: [interface: :eth0, mode: "auto"]

config :conreality, status_leds: [:green]

config :nerves_leds, names: [green: "led0"]
