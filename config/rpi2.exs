# Configuration for the Raspberry Pi 2 target (rpi2).

use Mix.Config

config :conreality, status_leds: [:red, :green]

config :nerves_leds, names: [red: "led0", green: "led1"]
