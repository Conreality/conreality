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
  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(Conreality.Machinery.Supervisor.Discovery, [], restart: :transient)
    ]
    supervise(children, strategy: :one_for_one)
  end

  defmodule Discovery do
    def start_link do
      Logger.info "Starting hardware discovery..."

      {:ok, spawn_link(__MODULE__, :init, [])}
    end

    def init do
      Logger.info "Performing hardware discovery..."

      # TODO: enumerate udev devices

      {:ok, _pid} = Supervisor.start_child(Conreality.Machinery.Supervisor,
        worker(Conreality.Machinery.Supervisor.Monitoring, [], restart: :permanent))
    end
  end

  defmodule Monitoring do
    def start_link do
      Logger.info "Starting hardware monitoring..."

      {:ok, spawn_link(__MODULE__, :init, [])}
    end

    def init do
      :timer.sleep(1_000_000) # TODO: monitor udev events
    end
  end
end
