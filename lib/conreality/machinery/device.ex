# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Device do
  @moduledoc """
  Device driver lifecycle.
  """

  import Supervisor.Spec
  alias Conreality.Machinery
  require Logger

  @spec start(binary, [binary]) :: {:ok, pid} | {:error, any}
  def start(device_path, device_links \\ []) do
    case find_driver(device_path, device_links) do
      {:ok, driver_module, driver_args} ->
        driver_spec = worker(driver_module, driver_args, id: device_path, restart: :permanent)

        case Supervisor.start_child(Machinery.Supervisor, driver_spec) do
          {:ok, pid} -> {:ok, pid}
          {:error, {:already_started, pid}} when is_pid(pid) -> {:ok, pid} # idempotency
        end

      {:error, reason} -> {:error, reason}
    end
  end

  @spec stop(binary) :: :ok | {:error, any}
  def stop(device_path) do
    if List.keymember?(Supervisor.which_children(Machinery.Supervisor), device_path, 0) do
      Logger.info "Stopping driver for #{device_path}..."

      case Supervisor.terminate_child(Machinery.Supervisor, device_path) do
        :ok -> :ok = Supervisor.delete_child(Machinery.Supervisor, device_path)
        {:error, :not_found} -> :ok # the driver wasn't loaded
      end
    else
      {:error, :unknown_device} # ignore any unknown devices
    end
  end

  @spec find_driver(binary, [binary]) :: {:ok, module, [term]} | {:error, atom}
  defp find_driver(device_path, device_links) do
    case String.split(device_path, "/") |> Enum.drop(1) do
      # /dev/input/event[0-9]+
      ["dev", "input", "event" <> _id] ->
        cond do
          Enum.find(device_links, &(String.ends_with?(&1, "-event-joystick"))) ->
            {:ok, Machinery.Gamepad, [device_path]}
          true ->
            {:error, :unknown_device}
        end

      # /dev/video[0-9]+:
      ["dev", "video" <> _id] ->
        {:ok, Machinery.Camera, [device_path]}

      _ -> {:error, :unknown_device} # ignore any unknown devices
    end
  end
end
