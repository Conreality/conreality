defmodule Conreality.Mixfile do
  use Mix.Project

  @name      "Conreality"
  @version   File.read!("VERSION") |> String.strip
  @github    "https://github.com/conreality/conreality"
  @bitbucket "https://bitbucket.org/conreality/conreality"
  @homepage  "https://conreality.org/"

  @target    System.get_env("NERVES_TARGET")

  def project do
    [app: :conreality,
     version: @version,
     elixir: "~> 1.3",
     target: @target,
     archives:   (if @target, do: [nerves_bootstrap: "~> 0.1.4"], else: []),
     deps_path:  (if @target, do: "deps/#{@target}", else: "deps/host"),
     build_path: (if @target, do: "_build/#{@target}", else: "_build/host"),
     build_embedded:  Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     name: @name,
     source_url: @github,
     homepage_url: @homepage,
     description: description(),
     aliases: aliases(@target),
     deps: deps() ++ target_deps(@target) ++ system(@target),
     package: package(),
     docs: [source_ref: @version, main: "readme", extras: ["README.md"]],
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
     applications: [
       :logger,
       :luerl,
       :nerves_leds,
       :nerves_lib,
       (if @target, do: :nerves_networking, else: nil),
       :nerves_ssdp_client,
       :nerves_ssdp_server,
     ] |> Enum.filter(&(&1))]
  end

  defp package do
    [files: ~w(lib priv src mix.exs CHANGES README.md UNLICENSE VERSION),
     maintainers: ["Conreality.org"],
     licenses: ["Public Domain"],
     links: %{"GitHub" => @github, "Bitbucket" => @bitbucket}]
  end

  defp description do
    """
    Augmented-reality wargame platform.
    """
  end

  defp dev_deps do
    [{:credo,             ">= 0.0.0", only: [:dev, :test]},
     {:dialyxir,          ">= 0.0.0", only: [:dev, :test]},
     {:earmark,           ">= 0.0.0", only: :dev},
     {:ex_doc,            ">= 0.0.0", only: :dev},
     {:excoveralls,       "~> 0.5.0", only: :test}]
  end

  defp deps do
    dev_deps() ++
    [{:exlua,             github: "bendiken/exlua", branch: "master"},
     {:luerl,             github: "bendiken/luerl", branch: "exlua",
                          compile: "make && cp src/luerl.app.src ebin/luerl.app"},
     {:gen_state_machine, "~> 1.0"},
     {:nerves_leds,       "~> 0.7.0"},
     {:nerves_lib,        github: "nerves-project/nerves_lib"},
     {:nerves_ssdp_client, "~> 0.1.3"},
     {:nerves_ssdp_server, "~> 0.2.1"}]
  end

  defp target_deps(nil), do: []

  defp target_deps(_target) do
    [{:nerves,            "~> 0.3.0"},
     {:nerves_networking, github: "nerves-project/nerves_networking", tag: "v0.6.0"}]
  end

  defp system(nil), do: []

  defp system(target) do
    [{:"nerves_system_#{target}", "~> 0.6.0"}]
  end

  defp aliases(nil), do: []

  defp aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end
end
