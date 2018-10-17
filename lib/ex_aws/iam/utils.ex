defmodule ExAws.Iam.Utils do
  @moduledoc false

  @doc """
  Converts the given list of params into a map using the given mapper.

  This function is used to convert parameters from snake_case, as is
  the Elixir convention, into PascalCase, the format used in AIM queries.

  ## Parameters

    * `mapper` - A map of query parameters. Each key-value pair should be the
      param name in snake_case and PascalCase respectively. 

    * `opts` - A keyword list of parameters to convert.

  ## Examples

      iex> ExAws.Iam.Utils.opts_to_params(%{username: "UserName"}, [username: "foo"])
      %{"UserName" => "foo"}

  """
  def opts_to_params(mapper, opts) do
    Enum.into(opts, %{}, fn {k, v} ->
      {Map.get(mapper, k), v}
    end)
  end  
end
