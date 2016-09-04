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
  alias Conreality.Machinery.InputDriver
  require Logger

  @spec start_link() :: {:ok, pid}
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec init([]) :: {:ok, {:supervisor.sup_flags, [Supervisor.Spec.spec]}}
  def init([]) do
    children = [
      worker(Conreality.Machinery.Supervisor.Discovery, [], restart: :transient)
    ]
    supervise(children, strategy: :one_for_one)
  end

  defmodule Discovery do
    @spec start_link() :: {:ok, pid}
    def start_link do
      Logger.info "Starting hardware discovery..."

      {:ok, spawn_link(__MODULE__, :init, [])}
    end

    @spec init() :: none
    def init do
      Logger.info "Performing hardware discovery..."

      # TODO: enumerate udev devices

      {:ok, _pid} = Supervisor.start_child(Conreality.Machinery.Supervisor,
        worker(Conreality.Machinery.Supervisor.Monitoring, [], restart: :permanent))
    end
  end

  defmodule Monitoring do
    @spec start_link() :: {:ok, pid}
    def start_link do
      Logger.info "Starting hardware monitoring..."

      InputDriver.start_script(["udev-monitor.py"], __MODULE__)
    end

    @spec handle_input({:add, binary, [binary]}) :: any
    def handle_input({:add, device_path, device_links}) do
      Logger.info "Hardware device added: #{device_path} #{inspect device_links}"
    end

    @spec handle_input({:remove, binary, [binary]}) :: any
    def handle_input({:remove, device_path, device_links}) do
      Logger.info "Hardware device removed: #{device_path} #{inspect device_links}"
    end

    @spec handle_input(term) :: any
    def handle_input(event) do
      Logger.warn "Hardware monitoring received an unknown event type: #{inspect event}"
    end

    @spec handle_exit(integer) :: any
    def handle_exit(code) do
      Logger.warn "Hardware monitoring process exited with code #{code}."
    end
  end
end
