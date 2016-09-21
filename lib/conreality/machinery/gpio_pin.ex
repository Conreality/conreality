# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.GPIO.Pin do
  @moduledoc """
  GPIO pin support.

  See: https://en.wikipedia.org/wiki/General-purpose_input/output
  """

  @type id        :: 0..255
  @type direction :: Gpio.pin_direction
  @type option    :: {atom, term}

  @spec start_link(id, direction, [option]) :: GenServer.on_start
  def start_link(id, direction, options \\ []) when is_integer(id) and is_atom(direction) do
    Gpio.start_link(id, direction, options)
  end
end
