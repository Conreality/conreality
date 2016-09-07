# This is free and unencumbered software released into the public domain.

defmodule Conreality.Status do
  @moduledoc """
  """

  import Supervisor.Spec
  alias Conreality.Machinery
  use GenStateMachine
  require Logger

  @spec start_link() :: GenServer.on_start
  def start_link do
    GenStateMachine.start_link(__MODULE__, [], name: __MODULE__)
  end

  def success do
    GenStateMachine.cast(__MODULE__, :success)
  end

  def failure do
    GenStateMachine.cast(__MODULE__, :failure)
  end

  @spec init([]) :: {:ok, any, any}
  def init([]) do
    {:ok, :configure_devices, [], [{:next_event, :cast, :start}]}
  end

  # Device Configuration

  def handle_event(:cast, :start, :configure_devices, data) do
    {:ok, _pid} = Supervisor.start_child(Machinery.Supervisor,
      worker(Machinery.DeviceConfiguration, [], restart: :transient))

    {:next_state, :configure_devices, data}
  end

  def handle_event(:cast, :failure, :configure_devices, data) do
    {:next_state, :configure_devices, data} # TODO
  end

  def handle_event(:cast, :success, :configure_devices, data) do
    {:next_state, :discover_devices, data, [{:next_event, :cast, :start}]}
  end

  # Device Discovery

  def handle_event(:cast, :start, :discover_devices, data) do
    {:ok, _pid} = Supervisor.start_child(Machinery.Supervisor,
      worker(Machinery.DeviceDiscovery, [], restart: :transient))

    {:next_state, :discover_devices, data}
  end

  def handle_event(:cast, :failure, :discover_devices, data) do
    {:next_state, :discover_devices, data} # TODO
  end

  def handle_event(:cast, :success, :discover_devices, data) do
    {:next_state, :monitor_devices, data, [{:next_event, :cast, :start}]}
  end

  # Device Monitoring

  def handle_event(:cast, :start, :monitor_devices, data) do
    {:ok, _pid} = Supervisor.start_child(Machinery.Supervisor,
      worker(Machinery.DeviceMonitoring, [], restart: :transient))

    {:next_state, :monitor_devices, data}
  end

  def handle_event(:cast, :failure, :monitor_devices, data) do
    {:next_state, :monitor_devices, data} # TODO
  end

  def handle_event(:cast, :success, :monitor_devices, data) do
    {:next_state, :initialization_done, data}
  end
end
