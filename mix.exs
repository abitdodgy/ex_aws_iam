defmodule Iam.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_iam,
      version: "0.1.3",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      name: "ExAws.IAM",
      source_url: "https://github.com/abitdodgy/ex_aws_iam",
      homepage_url: "https://github.com/abitdodgy/ex_aws_iam",
      package: package(),
      docs: [
        main: "readme",
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
      {:ex_aws, "~> 2.0"},
      {:sweet_xml, "~> 0.6"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    "An ExAws service module to interact with AWS IAM"
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Mohamad El-Husseini"],
      links: %{github: "https://github.com/abitdodgy/ex_aws_iam"}
    ]
  end
end
