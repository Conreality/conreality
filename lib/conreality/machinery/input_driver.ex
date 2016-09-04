# This is free and unencumbered software released into the public domain.

defmodule Conreality.Machinery.InputDriver do
  @moduledoc """
  Driver for input-only devices.
  """

  @spec start_script(list, module) :: {:ok, pid}
  def start_script([command | arguments], module) do
    priv_dir = :code.priv_dir(:conreality)

    start_link(["/usr/bin/env", "python3", "-u"] ++ ["#{priv_dir}/#{command}"] ++ arguments, module)
  end

  @spec start_link(list, module) :: {:ok, pid}
  def start_link(command_and_arguments, module) do
    {:ok, spawn_link(__MODULE__, :init, [command_and_arguments, module])}
  end

  @spec init(list, module) :: no_return
  def init([command | arguments], module) do
    Process.flag(:trap_exit, true)

    port = Port.open({:spawn_executable, command},
      [:binary,
       {:packet, 4},
       {:args, arguments},
       {:env, [{'PYTHONPATH', 'src/python'}]},
       :exit_status,
       :nouse_stdio])

    loop(port, module)
  end

  @spec loop(port, module) :: no_return
  def loop(port, module) do
    receive do
      {:EXIT, _from, :shutdown} ->
        Port.close(port)
        exit({:shutdown})

      {^port, {:exit_status, code}} ->
        apply(module, :handle_exit, code)
        exit({:shutdown, code})

      {^port, {:data, message}} ->
        input = :erlang.binary_to_term(message)
        apply(module, :handle_input, [input])
        loop(port, module)

      garbage ->
        :erlang.error({:badmatch, garbage})
    end
  end
end
