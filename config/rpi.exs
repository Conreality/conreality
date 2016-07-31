# Configuration for the Raspberry Pi A+ / B / B+ / Zero targets (rpi).

use Mix.Config

config :conreality, status_leds: [:red, :green]

config :nerves_leds, names: [red: "led0", green: "led1"]
