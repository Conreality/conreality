# This is free and unencumbered software released into the public domain.

defmodule Conreality.Scripting.Context do
  @moduledoc """
  """

  require Logger

  def new do
    priv_dir = :code.priv_dir(:conreality)
    Lua.State.new
    |> Lua.set_table([:package, :path], "#{priv_dir}/lua/?.lua")
    |> load_file("#{priv_dir}/lua/conreality/sdk.lua")
    |> Lua.gc
  end

  def load_module(state, module_name) do
    priv_dir = :code.priv_dir(:conreality)
    load_file(state, "#{priv_dir}/lua/conreality/sdk/#{module_name}.lua")
  end

  def load_file(state, file_path) do
    case Lua.load_file(state, file_path) do
      {:ok, state, chunk} ->
        {state, [_result]} = Lua.call_chunk!(state, chunk)
        state
    end
  end
end
