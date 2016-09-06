# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Supervisor do
  @moduledoc """
  Hardware driver supervision.

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
      worker(Machinery.DeviceDiscovery, [], restart: :transient)
    ]
    supervise(children, strategy: :one_for_one)
  end
end
