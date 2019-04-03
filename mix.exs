defmodule Deck.MixProject do
  use Mix.Project

  def project do
    [
      app: :deck,
      version: "1.0.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Deck",
      source_url: "https://github.com/svyatov/deck",
      description: description(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:benchee, "~> 1.0", only: :dev},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "Get, shuffle and deal a deck of playing cards of any size (from 4 to 52 cards)."
  end

  defp package do
    [
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/svyatov/deck"}
    ]
  end
end
