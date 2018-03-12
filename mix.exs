defmodule VCRMockHelper.MixProject do
  use Mix.Project

  def project do
    [
      app: :vcr_mock_helper,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "VCRMockHelper",
      source_url: "https://github.com/sudix/vcr_mock_helper",
      homepage_url: "https://github.com/sudix/vcr_mock_helper",
      docs: [main: "VCRMockHelper"]
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
      {:exvcr, "~> 0.10", optional: true},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false}
    ]
  end
end
