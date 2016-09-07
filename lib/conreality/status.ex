# This is free and unencumbered software released into the public domain.

defmodule Conreality.Status do
  @moduledoc """
  1. Device Configuration
  2. Device Discovery
  3. Device Monitoring
  4. Script Compilation
  5. Script Execution
  6. Event Handling
  7. Program Termination
  """

  import Supervisor.Spec
  alias Conreality.{Machinery, Scripting, Status}
  use GenStateMachine
  require Logger

  @spec start_link() :: GenServer.on_start
  def start_link do
    GenStateMachine.start_link(__MODULE__, [], name: __MODULE__)
  end

  def success, do: GenStateMachine.cast(__MODULE__, :success)
  def failure, do: GenStateMachine.cast(__MODULE__, :failure)

  @spec init([]) :: {:ok, any, any}
  def init([]) do
    {:ok, :configure_devices, [], [{:next_event, :cast, :start}]}
  end

  # 1. Device Configuration

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

  # 2. Device Discovery

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

  # 3. Device Monitoring

  def handle_event(:cast, :start, :monitor_devices, data) do
    {:ok, _pid} = Supervisor.start_child(Machinery.Supervisor,
      worker(Machinery.DeviceMonitoring, [], restart: :transient))

    {:next_state, :monitor_devices, data}
  end

  def handle_event(:cast, :failure, :monitor_devices, data) do
    {:next_state, :monitor_devices, data} # TODO
  end

  def handle_event(:cast, :success, :monitor_devices, data) do
    {:next_state, :compile_scripts, data, [{:next_event, :cast, :start}]}
  end

  # 4. Script Compilation

  def handle_event(:cast, :start, :compile_scripts, data) do
    spawn fn -> Status.success() end # TODO

    {:next_state, :compile_scripts, data}
  end

  def handle_event(:cast, :failure, :compile_scripts, data) do
    {:next_state, :compile_scripts, data} # TODO
  end

  def handle_event(:cast, :success, :compile_scripts, data) do
    {:next_state, :execute_scripts, data, [{:next_event, :cast, :start}]}
  end

  # 5. Script Execution

  def handle_event(:cast, :start, :execute_scripts, data) do
    script_path = Path.join(System.get_env("HOME") || "", "main.lua")

    if File.exists?(script_path) do
      {:ok, _pid} = Supervisor.start_child(Scripting.Supervisor,
        worker(Scripting, [script_path], restart: :transient, id: Scripting.MainScript))
    end

    {:next_state, :execute_scripts, data, [{:next_event, :cast, :success}]}
  end

  def handle_event(:cast, :failure, :execute_scripts, data) do
    {:next_state, :execute_scripts, data} # TODO
  end

  def handle_event(:cast, :success, :execute_scripts, data) do
    {:next_state, :handle_events, data, [{:next_event, :cast, :start}]}
  end

  # 6. Event Handling

  def handle_event(:cast, :start, :handle_events, data) do
    {:next_state, :handle_events, data} # loop
  end

  # 7. Program Termination
end
