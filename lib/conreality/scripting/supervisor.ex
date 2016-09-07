# This is free and unencumbered software released into the public domain.

defmodule Conreality.Scripting.Supervisor do
  @moduledoc """
  Scripting process supervision.
  """

  use Supervisor
  #alias Conreality.Scripting
  require Logger

  @spec start_link() :: {:ok, pid}
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec init([]) :: {:ok, {:supervisor.sup_flags, [Supervisor.Spec.spec]}}
  def init([]) do
    children = [] # populated by the Conreality.Status state machine
    supervise(children, strategy: :one_for_one)
  end
end
