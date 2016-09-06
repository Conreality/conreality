# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Gamepad do
  @moduledoc """
  Gamepad support.

  At present, this has been tested with PlayStation 3-compatible USB gamepad
  controllers.
  """

  alias Conreality.Machinery
  require Logger

  defmodule State do
    defstruct path: nil, current: %{}, pending: []

    @type t :: struct
  end

  @spec start_link(non_neg_integer) :: {:ok, port} | {:error, any}
  def start_link(event_id) when is_integer(event_id) do
    start_link("/dev/input/event#{event_id}")
  end

  @spec start_link(binary) :: {:ok, port} | {:error, any}
  def start_link(device_path) when is_binary(device_path) do
    Logger.info "Starting gamepad driver for #{device_path}..."

    ["evdev-device.py", device_path]
    |> Machinery.InputDriver.start_script(__MODULE__, %State{path: device_path})
  end

  @spec handle_exit(integer, State.t) :: any
  def handle_exit(code, state) do
    Logger.warn "Gamepad driver for #{state.path} exited with code #{code}."
  end

  @spec handle_input({float, :EV_SYN, :SYN_REPORT, 0}, State.t) :: State.t
  def handle_input({_timestamp, :EV_SYN, :SYN_REPORT, 0}, state) do
    _state = handle_events(state)
  end

  @spec handle_input({float, atom, atom, integer}, State.t) :: State.t
  def handle_input({_timestamp, _event_type, _event_code, _event_value} = event, state) do
    _state = %{state | pending: [event | state.pending]}
  end

  @spec handle_events(State.t) :: State.t
  def handle_events(state) do
    current = Enum.reduce(state.pending, state.current, fn(event, current) ->
      case event do
        {_, :EV_ABS, event_code, event_value} ->
          Map.put(current, event_code, event_value)
        _ -> current # ignore unknown event types
      end
    end)
    _state = %{state | pending: [], current: current}
  end
end
