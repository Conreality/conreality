defmodule Conreality do
  use Application

  # See: http://elixir-lang.org/docs/stable/elixir/Application.html
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and sub-supervisors to be supervised:
    status_leds = Application.get_env(:conreality, :status_leds) || []
    children = [
      worker(Conreality.Blinker, [status_leds]),
      worker(Conreality.Networking, []),
    ]

    # See: http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # ...for other strategies and supported options:
    opts = [strategy: :one_for_one, name: Conreality.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
