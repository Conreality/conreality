# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.InputDriver do
  @moduledoc """
  Driver for input-only devices.
  """

  @spec start_script([binary, ...], module, any) :: {:ok, pid}
  def start_script([command | arguments], module, initial_state \\ nil) do
    priv_dir = :code.priv_dir(:conreality)
    command_and_arguments = ["/usr/bin/env", "python3", "-u", "#{priv_dir}/#{command}"] ++ arguments
    start_link(command_and_arguments, module, initial_state)
  end

  @spec start_link([binary, ...], module, any) :: {:ok, pid}
  def start_link(command_and_arguments, module, initial_state \\ nil) do
    {:ok, spawn_link(__MODULE__, :init,
     [command_and_arguments, module, initial_state])}
  end

  @spec init([binary, ...], module, any) :: no_return
  def init([command | arguments], module, state) do
    Process.flag(:trap_exit, true)

    port = Port.open({:spawn_executable, command},
      [:binary,
       {:packet, 4},
       {:args, arguments},
       {:env, [{'PYTHONPATH', 'priv/python'}]},
       :exit_status,
       :nouse_stdio])

    loop(port, module, state)
  end

  @spec loop(port, module, any) :: no_return
  def loop(port, module, state) do
    receive do
      {:EXIT, _from, :shutdown} ->
        Port.close(port)
        exit({:shutdown})

      {^port, {:exit_status, code}} ->
        apply(module, :handle_exit, [code, state])
        exit({:shutdown, code})

      {^port, {:data, message}} ->
        input = :erlang.binary_to_term(message)
        state = apply(module, :handle_input, [input, state])
        loop(port, module, state)

      garbage ->
        :erlang.error({:badmatch, garbage})
    end
  end
end
