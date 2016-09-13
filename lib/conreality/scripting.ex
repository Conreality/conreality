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

  @spec package_path() :: binary
  def package_path do
    path_to("?.lua") # "priv/lua/?.lua"
  end

  @spec start_link(binary, Lua.State.t)
    :: GenServer.on_start | {:error, any, any}
  def start_link(filepath, state \\ nil) when is_binary(filepath) do
    Lua.Thread.start_link(filepath, state, name: __MODULE__)
  end

  @spec call_function(atom | [atom], [term]) :: [term]
  def call_function(function_name, function_args \\ []) do
    Lua.Thread.call_function(__MODULE__, function_name, function_args)
  end

  @spec exec_function(atom | [atom], [term]) :: :ok
  def exec_function(function_name, function_args \\ []) do
    Lua.Thread.exec_function(__MODULE__, function_name, function_args)
  end
end
