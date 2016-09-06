# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Supervisor do
  @moduledoc """
  Hardware device supervision.

  This supervisor process detects and initializes any supported hardware
  devices present when the system is booted, as well as handles dynamic
  ("hotplug") device addition and removal events at runtime.

  Device discovery and monitoring utilizes Linux's udev subsystem.
  """

  use Supervisor
  alias Conreality.Machinery
  require Logger

  @spec start_link() :: {:ok, pid}
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec init([]) :: {:ok, {:supervisor.sup_flags, [Supervisor.Spec.spec]}}
  def init([]) do
    children = [
      worker(Machinery.Supervisor.Discovery, [], restart: :transient)
    ]
    supervise(children, strategy: :one_for_one)
  end

  defmodule Discovery do
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
        worker(Machinery.Supervisor.Monitoring, [], restart: :permanent))
    end

    @spec handle_exit(integer, State.t) :: any
    def handle_exit(code, _state) do
      Logger.warn "Hardware discovery failed with code #{code}."
    end
  end

  defmodule Monitoring do
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
end
