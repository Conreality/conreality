# This is free and unencumbered software released into the public domain.

defmodule Conreality.Scripting do
  @moduledoc """
  """

  @spec path() :: binary
  def path do
    Path.join(:code.priv_dir(:conreality), "lua")
  end

  @spec start_link(binary, Lua.State.t) :: {:ok, pid} | {:error, any, any}
  def start_link(filepath, state \\ nil) when is_binary(filepath) do
    Lua.Thread.start_link(filepath, state)
  end
end
