defmodule Conreality.Networking do
  require Logger

  @config Application.get_env(:conreality, :networking)

  def start_link do
    Logger.info "Networking configuration: #{inspect @config}"
    {_, interface} = List.keyfind(@config, :interface, 0)
    settings = List.keydelete(@config, :interface, 0)
    GenServer.start_link(Nerves.Networking.Server, {interface, settings}, name: interface)
  end
end
