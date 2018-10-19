defmodule ExAws.Iam.Parsers.GroupTest do
  use ExUnit.Case

  import ExAws.Iam.TestHelper, only: [read_file: 2]

  alias ExAws.Iam.Parser

  test "create/2" do
    xml = read_file("group", "create")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           create_group_result: %{
             group: %{
               arn: "arn:aws:iam::085326204011:group/foo",
               create_date: "2018-10-19T22:04:37Z",
               path: "/",
               group_id: "AGPAIDI3XY2DD433B73WG",
               group_name: "foo"
             }
           },
           response_metadata: %{
             request_id: "f7fb9d1a-d3ea-11e8-8b50-27e8923234d4"
           }
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "CreateGroup")
  end
end
