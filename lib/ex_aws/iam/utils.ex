defmodule ExAws.Iam.Utils do
  @moduledoc false

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
end
