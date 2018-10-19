defmodule ExAws.Iam.Parsers.Metadata do
  @moduledoc """
  Defines parsers for handling AWS IAM reponses that
  contain only metadata.

  """

  import SweetXml, only: [sigil_x: 2]
  import ExAws.Iam.Utils, only: [response_metadata_path: 0]

  @doc """
  A generic parser for responses that contain only metadata.

  """
  def parse(xml, action) do
    action = action <> "Response"

    atom_action =
      action
      |> Macro.underscore()
      |> String.to_atom()

    SweetXml.xpath(xml, ~x"//#{action}", [
      {atom_action,
       [
         ~x"//#{action}",
         response_metadata: response_metadata_path()
       ]}
    ])
  end
end
