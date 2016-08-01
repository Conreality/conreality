defmodule Conreality.Mixfile do
  use Mix.Project

  @target System.get_env("CONREAL_TARGET") ||  System.get_env("NERVES_TARGET") || "qemu_arm"

  def project do
    [app: :conreality,
     version: "0.0.1",
     elixir: "~> 1.3",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [
       "coveralls": :test,
       "coveralls.detail": :test,
       "coveralls.post": :test,
       "coveralls.html": :test,
     ]]
  end

  def application do
    [mod: {Conreality, []},
     applications: [:logger, :nerves_leds, :nerves_lib, :nerves_networking]]
  end

  def deps do
    [{:excoveralls, "~> 0.5.0", only: :test},
     {:nerves, "~> 0.3.0"},
     {:nerves_leds, "~> 0.7.0"},
     {:nerves_lib, github: "nerves-project/nerves_lib"},
     {:nerves_networking, github: "nerves-project/nerves_networking", tag: "v0.6.0"}]
  end

  def system(nil), do: []

  def system(target) do
    [{:"nerves_system_#{target}", "~> 0.6.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end
end
