# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Gamepad do
  @moduledoc """
  Gamepad support for Conreality.

  At present, this has been tested with PlayStation 3-compatible gamepad
  controllers.
  """

  @spec open(non_neg_integer) :: {:ok, port} | {:error, any}
  def open(evdev_id) when is_integer(evdev_id) do
    open("/dev/input/event#{evdev_id}")
  end

  @spec open(binary) :: {:ok, port} | {:error, any}
  def open(device) when is_binary(device) do
    priv_dir = :code.priv_dir(:conreality)
    Port.open({:spawn_executable, "/usr/bin/env"},
      [:binary,
       {:packet, 4},
       {:args, ["python3", "-u", "#{priv_dir}/evdev-device.py", device]},
       {:env, [{'PYTHONPATH', 'src/python'}]},
       :nouse_stdio])
  end

  @spec close(port) :: true
  def close(port) do
    Port.close(port)
  end

  @spec read(port) :: term
  def read(port) do
    receive do
      {^port, {:data, response}} -> :erlang.binary_to_term(response)
    end
  end
end
