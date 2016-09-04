# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Device do
  @moduledoc """
  Device driver loading/unloading.
  """

  import Supervisor.Spec
  alias Conreality.Machinery
  require Logger

  @spec start(binary) :: {:ok, pid} | {:error, any}
  def start(device_path) do
    case String.split(device_path, "/") |> Enum.drop(1) do
      # /dev/videoN:
      ["dev", "video" <> _id] ->
        spec = worker(Machinery.Camera, [device_path], id: device_path, restart: :permanent)
        case Supervisor.start_child(Machinery.Supervisor, spec) do
          {:ok, pid} -> {:ok, pid}
          {:error, {:already_started, pid}} -> {:ok, pid} # idempotency
        end

      _ -> {:error, :unknown_device} # ignore any unknown devices
    end
  end

  @spec stop(binary) :: :ok | {:error, any}
  def stop(device_path) do
    case String.split(device_path, "/") |> Enum.drop(1) do
      # /dev/videoN:
      ["dev", "video" <> _id] ->
        Logger.info "Stopping driver for #{device_path}..."

        case Supervisor.terminate_child(Machinery.Supervisor, device_path) do
          :ok -> :ok = Supervisor.delete_child(Machinery.Supervisor, device_path)
          {:error, :not_found} -> :ok # the driver wasn't loaded
        end

      _ -> {:error, :unknown_device} # ignore any unknown devices
    end
  end
end
