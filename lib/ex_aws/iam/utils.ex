defmodule ExAws.Iam.Utils do
  @moduledoc false

  import SweetXml, only: [sigil_x: 2]

  @doc """
  Converts the given keyword list into a map with string and camelcase keys.

  Use this to convert parameters into the correct casing as required
  by the AWS IAM query API.

  ## Parameters

    * `list` - A keyword list to convert.

  ## Examples

      iex> ExAws.Iam.Utils.list_to_camelized_map([user_name: "my_user"])
      %{"UserName" => "my_user"}

  """
  def list_to_camelized_map(list) do
    Enum.into(list, %{}, fn {k, v} ->
      {camelize(k), v}
    end)
  end

  @doc """
  Converts the given atom to a CamelCase string.

  ## Examples

      iex> ExAws.Iam.Utils.camelize(:user_name)
      "UserName"

  """
  def camelize(atom) when is_atom(atom) do
    atom
    |> Atom.to_string()
    |> Macro.camelize()
  end

  @doc """
  Returns the XML path for IAM request metadata.

  """
  def response_metadata_path do
    [~x"//ResponseMetadata", request_id: ~x"./RequestId/text()"s]
  end

  @doc """
  Converts string boolean to boolean
  """
  def to_boolean(xpath) do
    xpath |> SweetXml.transform_by(&(&1 == "true"))
  end
end
