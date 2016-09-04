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

      {:ok, spawn_link(__MODULE__, :init, [])}
    end

    @spec init() :: no_return
    def init do
      priv_dir = :code.priv_dir(:conreality)

      port = Port.open({:spawn_executable, "/usr/bin/env"},
        [:binary, :in,
         {:packet, 4},
         {:args, ["python3", "-u", "#{priv_dir}/udev-monitor.py"]},
         {:env, [{'PYTHONPATH', 'src/python'}]},
         :exit_status,
         :nouse_stdio])

      loop(port)
    end

    @spec loop(port) :: no_return
    def loop(port) do
      event = read(port)

      IO.inspect event # TODO

      loop(port)
    end

    @spec read(port) :: no_return | term
    def read(port) do
      receive do
        {^port, {:exit_status, code}} ->
          Logger.warn "Hardware monitoring process exited with code #{code}."
          exit({:shutdown, code})

        {^port, {:data, message}} ->
          :erlang.binary_to_term(message)

        garbage ->
          Logger.error "Hardware monitoring process received an unexpected message: #{inspect garbage}."
          :erlang.error({:badmatch, garbage})
      end
    end
  end
end
