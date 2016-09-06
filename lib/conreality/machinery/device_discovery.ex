# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.DeviceDiscovery do
  @moduledoc """
  """

  import Supervisor.Spec
  alias Conreality.Machinery
  require Logger

  defmodule State do
    defstruct unused: nil

    @type t :: struct
  end

  @spec start_link() :: {:ok, pid}
  def start_link do
    Logger.info "Starting hardware discovery..."

    Machinery.InputDriver.start_script(["udev-enumerate.py"], __MODULE__, %State{})
  end

  @spec handle_input({binary, [binary]}, State.t) :: State.t
  def handle_input({device_path, device_links}, state) do
    Machinery.Device.start(device_path, device_links)

    state
  end

  @spec handle_input(term, State.t) :: State.t
  def handle_input(event, state) do
    Logger.warn "Hardware discovery ignored unexpected input: #{inspect event}"

    state
  end

  @spec handle_exit(0, State.t) :: any
  def handle_exit(0, _state) do
    Logger.info "Hardware discovery completed."

    {:ok, _pid} = Supervisor.start_child(Machinery.Supervisor,
      worker(Machinery.DeviceMonitoring, [], restart: :permanent))
  end

  @spec handle_exit(integer, State.t) :: any
  def handle_exit(code, _state) do
    Logger.warn "Hardware discovery failed with code #{code}."
  end
end
