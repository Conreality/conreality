# This is free and unencumbered software released into the public domain.

defmodule Conreality do
  use Application
  alias Nerves.Lib.UUID

  @platform    Application.get_env(:conreality, :platform)
  @networking  Application.get_env(:conreality, :networking)
  @status_leds Application.get_env(:conreality, :status_leds)

  # See: http://elixir-lang.org/docs/stable/elixir/Application.html
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and sub-supervisors to be supervised.
    # See: http://elixir-lang.org/docs/stable/elixir/Supervisor.Spec.html
    children = [
      supervisor(Conreality.Machinery.Supervisor, []),
      (if @status_leds, do: worker(Conreality.Blinker, [@status_leds]), else: nil),
      (if @networking,  do: worker(Conreality.Networking, []),          else: nil),
      worker(Conreality.Discovery, [UUID.generate], restart: :transient),
    ] |> Enum.filter(&(&1))

    # See: http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # ...for other strategies and supported options:
    opts = [strategy: :one_for_one, name: Conreality.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
