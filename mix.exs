defmodule PromisepayEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :promisepay_ex,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "PromisepayEx",
      source_url: "https://github.com/psyfear/promisepay_ex",
      homepage_url: "https://github.com/psyfear/promisepay_ex",
      docs: [
        main: "PromisepayEx", # The main page in the docs
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :httpoison],
     mod: {PromisepayEx, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 3.1.0"},
      {:httpoison, "~> 0.11.0"},
      {:ex_doc, "~> 0.14", only: :dev},
    ]
  end
end
