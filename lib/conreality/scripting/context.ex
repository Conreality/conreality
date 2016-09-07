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
    |> Lua.gc
  end

  @spec load_sdk(Lua.State.t) :: Lua.State.t
  def load_sdk(state) do
    {state, [table]} = state |> Lua.require!("conreality.sdk")
    state
  end
end
