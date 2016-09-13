# This is free and unencumbered software released into the public domain.

defmodule Conreality.Scripting.Context do
  @moduledoc """
  """

  alias Conreality.Scripting
  require Logger

  @spec new() :: Lua.State.t
  def new do
    Lua.State.new
    |> Lua.set_package_path(Scripting.package_path())
    |> load_sdk_package()
    |> exec_prelude()
    |> define_machinery()
    |> import_hardware()
    |> Lua.gc
  end

  @spec load_sdk_package(Lua.State.t) :: Lua.State.t
  defp load_sdk_package(state) do
    {state, _} = state |> Lua.require!("conreality.sdk")
    state
  end

  @spec exec_prelude(Lua.State.t) :: Lua.State.t
  defp exec_prelude(state) do
    state |> Lua.exec_file!(Scripting.path_to("prelude.lua"))
  end

  @spec define_machinery(Lua.State.t) :: Lua.State.t
  defp define_machinery(state) do
    state
    |> Lua.set_table([:Gamepad, :__index], fn [_tref, key] ->
         case key do
           "x" -> [1]; "y" -> [2]; "z" -> [3]; _ -> nil
         end
       end)
  end

  @spec import_hardware(Lua.State.t) :: Lua.State.t
  defp import_hardware(state) do
    state
    |> Lua.set_global(:gamepad, %{})
    |> Lua.exec!("setmetatable(gamepad, Gamepad); return nil")
  end
end
