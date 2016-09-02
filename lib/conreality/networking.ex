# This is free and unencumbered software released into the public domain.

defmodule Conreality.Networking do
  require Logger

  @networking Application.get_env(:conreality, :networking)

  def start_link do
    Logger.info "Configuring networking: #{inspect @networking}"

    {_, interface} = List.keyfind(@networking, :interface, 0)
    settings = List.keydelete(@networking, :interface, 0)

    {:ok, _pid} = GenServer.start_link(
      Nerves.Networking.Server,
      {interface, settings}, name: interface)
  end
end
