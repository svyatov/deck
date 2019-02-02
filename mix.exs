defmodule Deck.MixProject do
  use Mix.Project

  def project do
    [
      app: :deck,
      version: "1.0.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Deck",
      source_url: "https://github.com/svyatov/deck",
      homepage_url: "https://github.com/svyatov/deck",
      docs: [
        main: "Deck",
        extras: ["README.md"]
      ]
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
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:benchee, "~> 0.13", only: :dev}
    ]
  end
end
