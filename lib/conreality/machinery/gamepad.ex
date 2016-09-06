# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Gamepad do
  @moduledoc """
  Gamepad support.

  At present, this has been tested with PlayStation 3-compatible USB gamepad
  controllers.
  """

  alias Conreality.Machinery
  require Logger

  @spec start_link(non_neg_integer) :: {:ok, port} | {:error, any}
  def start_link(event_id) when is_integer(event_id) do
    start_link("/dev/input/event#{event_id}")
  end

  @spec start_link(binary) :: {:ok, port} | {:error, any}
  def start_link(device_path) when is_binary(device_path) do
    Logger.info "Starting gamepad driver for #{device_path}..."

    ["evdev-device.py", device_path]
    |> Machinery.InputDriver.start_script(__MODULE__, [])
  end

  @spec handle_input({float, atom, atom, integer}, any) :: any
  def handle_input({timestamp, event_type, event_code, event_value}, state) do
    Logger.info "Gamepad driver: #{timestamp} #{event_type} #{event_code} #{event_value}" # TODO

    state
  end

  @spec handle_input(term, any) :: any
  def handle_input(event, state) do
    Logger.warn "Gamepad driver ignored unexpected input: #{inspect event}"

    state
  end

  @spec handle_exit(integer, any) :: any
  def handle_exit(code, _state) do
    Logger.warn "Gamepad driver exited with code #{code}."
  end
end
