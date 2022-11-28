defmodule ExTicTacToe.MixProject do
  use Mix.Project

  def project do
    [
      name: "ExTicTacToe",
      package: package(),
      description: description(),
      app: :ex_tic_tac_toe,
      version: "0.2.2",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.1", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE.txt),
      licenses: ["AGPL-3.0-or-later"],
      links: %{"GitHub" => "https://github.com/filipmnowak/ex_tic_tac_toe"}
    ]
  end

  defp description() do
    "Elixir, MapSet-based, variable board size, Tic-tac-toe implementation (WIP)."
  end
end
