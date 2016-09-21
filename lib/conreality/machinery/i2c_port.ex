# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.I2C.Port do
  @moduledoc """
  I²C support.

  See: https://en.wikipedia.org/wiki/I%C2%B2C
  """

  @type bus     :: 0..255
  @type address :: I2c.i2c_address
  @type option  :: {atom, term}

  def start_link(bus, address, options \\ [])

  @spec start_link(bus, address, [option]) :: GenServer.on_start
  def start_link(bus, address, options) when is_integer(bus) and is_integer(address) do
    start_link("i2c-#{bus}", address, options)
  end

  @spec start_link(binary, address, [option]) :: GenServer.on_start
  def start_link(bus, address, options) when is_binary(bus) and is_integer(address) do
    I2c.start_link(bus, address, options)
  end
end
