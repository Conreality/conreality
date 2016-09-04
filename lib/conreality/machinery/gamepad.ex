# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Gamepad do
  @moduledoc """
  Gamepad support.

  At present, this has been tested with PlayStation 3-compatible USB gamepad
  controllers.
  """

  require Logger

  @spec open(non_neg_integer) :: {:ok, port} | {:error, any}
  def open(event_id) when is_integer(event_id) do
    open("/dev/input/event#{event_id}")
  end

  @spec open(binary) :: {:ok, port} | {:error, any}
  def open(device_path) when is_binary(device_path) do
    Logger.debug "Starting gamepad process for #{device_path}..."

    ["evdev-device.py", device_path]
    |> InputDriver.start_script(__MODULE__)
  end

  @spec handle_input(term) :: any
  def handle_input(event) do
    IO.inspect event # TODO
  end

  @spec handle_exit(integer) :: any
  def handle_exit(code) do
    Logger.warn "Gamepad process exited with code #{code}."
  end
end
