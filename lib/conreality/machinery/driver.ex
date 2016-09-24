# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.Driver do
  @moduledoc """
  Driver for input/output devices.
  """

  use GenServer

  @spec start_script([binary, ...], module, any, GenServer.options) :: GenServer.on_start
  def start_script([command | arguments], module, init_args, options \\ []) do
    priv_dir = :code.priv_dir(:conreality)
    command_and_arguments = ["/usr/bin/env", "python3", "-u", "#{priv_dir}/#{command}"] ++ arguments
    start_link(command_and_arguments, module, init_args, options)
  end

  @spec start_link([binary, ...], module, any, GenServer.options) :: GenServer.on_start
  def start_link(command_and_arguments, module, init_args, options \\ []) do
    GenServer.start_link(__MODULE__, {command_and_arguments, module, init_args}, options)
  end

  @spec init({[binary, ...], module, any}) :: any
  def init({[command | arguments], module, init_args}) do
    Process.flag(:trap_exit, true)

    port = Port.open({:spawn_executable, command},
      [:binary,
       {:packet, 4},
       {:args, arguments},
       {:env, [{'PYTHONPATH', 'priv/python'}]},
       :exit_status,
       :nouse_stdio])

    {:ok, state} = apply(module, :init, [port, init_args])

    {:ok, {port, state}}
  end

  @spec handle_cast(any, any) :: {:noreply, any}
  def handle_cast(request, {port, state}) do
    Port.command(port, :erlang.term_to_binary(request))
    {:noreply, {port, state}}
  end

  @spec handle_call(any, any, any) :: {:reply, any, any}
  def handle_call(request, _from, {port, state}) do
    Port.command(port, :erlang.term_to_binary(request))
    response = receive do
      {^port, {:data, response}} ->
        :erlang.binary_to_term(response)
    end
    {:reply, response, {port, state}}
  end

  @spec handle_info(any, any) :: {:noreply, any}
  def handle_info(message, {port, state}) do
    IO.inspect {:handle_info, message} # TODO
    case message do
      {^port, {:exit_status, _code}} ->
        {:noreply, {port, state}}

      {:EXIT, ^port, reason} ->
        #Port.close(port)
        {:stop, :terminated, {port, state}}

      garbage ->
        :erlang.error({:badmatch, garbage})
    end
  end
end
