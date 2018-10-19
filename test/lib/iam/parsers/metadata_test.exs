defmodule ExAws.Iam.Parsers.MetadataTest do
  use ExUnit.Case

  alias ExAws.Iam.Parser

  @actions ~w[
    UpdateAccessKey
    UpdateGroup
    UpdateUser
    DeleteAccessKey
    DeleteGroup
    DeleteUser
  ]

  test "parse/2 parses requests that return generic meta data" do
    Enum.each(@actions, fn action ->
      xml = response(action)
      resp = {:ok, %{body: xml, status_code: 200}}

      atom_action =
        action
        |> Kernel.<>("Response")
        |> Macro.underscore()
        |> String.to_atom()

      expected =
        {:ok,
         %{
           body: %{
             atom_action => %{
               response_metadata: %{
                 request_id: "fea09bbb-d213-11e8-bd77-49651db80edb"
               }
             }
           },
           status_code: 200
         }}

      assert expected == Parser.parse(resp, action)
    end)
  end

  defp response(action) do
    """
    <#{action}Response xmlns="https://iam.amazonaws.com/doc/2010-05-08/">
        <ResponseMetadata>
            <RequestId>fea09bbb-d213-11e8-bd77-49651db80edb</RequestId>
        </ResponseMetadata>
    </#{action}Response>
    """
  end
end
