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
    |> load_sdk()
    |> exec_prelude()
    |> Lua.gc
  end

  @spec load_sdk(Lua.State.t) :: Lua.State.t
  def load_sdk(state) do
    {state, [_]} = state |> Lua.require!("conreality.sdk")
    state
  end

  @spec exec_prelude(Lua.State.t) :: Lua.State.t
  def exec_prelude(state) do
    state = Lua.State.unwrap(state)
    {_, state} = :luerl.dofile(Scripting.path_to("prelude.lua") |> String.to_charlist, state)
    Lua.State.wrap(state)
  end
end
