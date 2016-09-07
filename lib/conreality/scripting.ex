# This is free and unencumbered software released into the public domain.

defmodule Conreality.Scripting do
  @moduledoc """
  """

  @spec path() :: binary
  def path do
    Path.join(:code.priv_dir(:conreality), "lua")
  end

  @spec path_to(binary) :: binary
  def path_to(file_name) do
    Path.join(path(), file_name)
  end

  @spec start_link(binary, Lua.State.t) :: {:ok, pid} | {:error, any, any}
  def start_link(filepath, state \\ nil) when is_binary(filepath) do
    Lua.Thread.start_link(filepath, state)
  end
end
