# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.DeviceConfiguration do
  @moduledoc """
  """

  import Supervisor.Spec
  alias Conreality.Machinery
  require Logger

  @spec start_link() :: {:ok, pid}
  def start_link do
    Logger.info "Starting hardware configuration..."

    {:ok, spawn_link(__MODULE__, :init, [])}
  end

  @spec init() :: any
  def init do
    # TODO: read configuration file.

    Logger.info "Hardware configuration completed."

    {:ok, _pid} = Supervisor.start_child(Machinery.Supervisor,
      worker(Machinery.DeviceDiscovery, [], restart: :transient))
  end
end
