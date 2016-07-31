# Configuration for the Raspberry Pi 3 target (rpi3).

use Mix.Config

config :conreality, status_leds: [:green]

config :nerves_leds, names: [green: "led0"]
