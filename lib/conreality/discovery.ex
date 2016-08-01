defmodule Conreality.Discovery do
  alias Nerves.SSDPServer
  require Logger

  @ssdp_st "urn:nerves-project-org:service:cell:1"

  def start_link(uuid) do
    {:ok, spawn_link(fn -> announce(uuid) end)}
  end

  def announce(uuid) do
    usn = "uuid:" <> uuid
    meta = []
    Logger.info "Announcing SSDP USN #{inspect uuid} and ST #{inspect @ssdp_st}."
    {:ok, ^usn} = SSDPServer.publish(usn, @ssdp_st, meta)
  end

  def _discover do
    # TODO
  end
end
