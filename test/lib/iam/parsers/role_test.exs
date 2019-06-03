defmodule ExAws.Iam.Parsers.RoleTest do
  use ExUnit.Case

  import ExAws.Iam.TestHelper, only: [read_file: 2]

  alias ExAws.Iam.Parser

  test "list_roles/2" do
    xml = read_file("role", "list_roles")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           list_roles_result: %{
             is_truncated: "false",
             marker: nil,
             roles: [
               %{
                 arn: "arn:aws:iam::085326204011:role/foo",
                 assume_role_policy_document:
                   "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}",
                 create_date: "2018-10-19T22:04:37Z",
                 max_session_duration: "3600",
                 path: "/",
                 role_id: "AGPAIDI3XY2DD433B73WG",
                 role_name: "foo"
               }
             ]
           },
           response_metadata: %{request_id: "81ca4919-d3fb-11e8-986e-5fbe089ad211"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "ListRoles")
  end

  test "list_role_tags/2" do
    xml = read_file("role", "list_role_tags")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           list_role_tags_result: %{
             is_truncated: "false",
             marker: nil,
             tags: [
               %{key: "UserRole", value: "developer"}
             ]
           },
           response_metadata: %{request_id: "81ca4919-d3fb-11e8-986e-5fbe089ad211"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "ListRoleTags")
  end
end
