# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.DeviceMonitoring do
  @moduledoc """
  """

  alias Conreality.Machinery
  require Logger

  defmodule State do
    defstruct unused: nil

    @type t :: struct
  end

  @spec start_link() :: {:ok, pid}
  def start_link do
    Logger.info "Starting hardware monitoring..."

    Machinery.InputDriver.start_script(["udev-monitor.py"], __MODULE__, %State{})
  end

  @spec handle_input({:add, binary, [binary]}, State.t) :: State.t
  def handle_input({:add, device_path, device_links}, state) do
    Logger.debug "Hardware device added: #{device_path} #{inspect device_links}"

    Machinery.Device.start(device_path, device_links)

    state
  end

  @spec handle_input({:remove, binary, [binary]}, State.t) :: State.t
  def handle_input({:remove, device_path, device_links}, state) do
    Logger.debug "Hardware device removed: #{device_path} #{inspect device_links}"

    Machinery.Device.stop(device_path)

    state
  end

  @spec handle_input(term, State.t) :: State.t
  def handle_input(event, state) do
    Logger.warn "Hardware monitoring ignored unexpected input: #{inspect event}"

    state
  end

  @spec handle_exit(integer, State.t) :: any
  def handle_exit(code, _state) do
    Logger.warn "Hardware monitoring process exited with code #{code}."
  end
end
