# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.SPI.Device do
  @moduledoc """
  SPI device support.

  See: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus
  """

  @type bus    :: 0..255
  @type chip   :: 0..255
  @type option :: Spi.spi_option | {atom, term}

  @spec start_link(bus, chip, [term]) :: GenServer.on_start
  def start_link(bus, chip, options \\ []) when is_integer(bus) and is_integer(chip) do
    Spi.start_link("spidev#{bus}.#{chip}", options, [])
  end
end
