# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Camera do
  @moduledoc """
  Camera support.
  """

  require Logger

  @spec open(non_neg_integer) :: {:ok, port} | {:error, any}
  def open(video_id) when is_integer(video_id) do
    open("/dev/video#{video_id}")
  end

  @spec open(binary) :: {:ok, port} | {:error, any}
  def open(device_path) when is_binary(device_path) do
    Logger.debug "Starting camera driver for #{device_path}..."

    ["v4l2-camera.py", device_path]
    |> InputDriver.start_script(__MODULE__)
  end

  @spec handle_input(term) :: any
  def handle_input(event) do
    Logger.warn "Camera driver ignored unexpected input: #{inspect event}" # TODO
  end

  @spec handle_exit(integer) :: any
  def handle_exit(code) do
    Logger.warn "Camera driver exited with code #{code}."
  end
end
