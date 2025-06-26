defmodule ExAws.Iam.Parsers.UserTest do
  use ExUnit.Case

  import ExAws.Iam.TestHelper, only: [read_file: 2]

  alias ExAws.Iam.Parser

  test "list/2" do
    xml = read_file("user", "list")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           list_users_result: %{
             is_truncated: "false",
             marker: nil,
             users: [
               %{
                 arn: "arn:aws:iam::085326204011:user/baz/bar",
                 create_date: "2018-10-17T00:09:19Z",
                 path: "/baz/",
                 user_id: "AIDAIAPPW7ERTKFL2R3TI",
                 user_name: "bar"
               },
               %{
                 arn: "arn:aws:iam::085326204011:user/some_user",
                 create_date: "2018-10-14T18:31:50Z",
                 path: "/",
                 user_id: "AIDAJZTLCIRAWNUUPBREC",
                 user_name: "some_user"
               }
             ]
           },
           response_metadata: %{request_id: "25c67fa6-d212-11e8-b8d6-a7951e68fc2c"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "ListUsers")
  end

  test "get/2" do
    xml = read_file("user", "get")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           get_user_result: %{
             user: %{
               arn: "arn:aws:iam::085326204011:user/foo",
               create_date: "2018-10-14T18:31:50Z",
               path: "/",
               user_id: "AIDAJZTLCIRAWNUUPBREC",
               user_name: "foo",
               tags: [%{key: "SomeKey0", value: "SomeValue0"}, %{key: "SomeKey1", value: "SomeValue1"}]
             }
           },
           response_metadata: %{request_id: "21a662e8-d27c-11e8-921e-e7a12b78bc94"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "GetUser")
  end

  test "create/2" do
    xml = read_file("user", "create")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           create_user_result: %{
             user: %{
               arn: "arn:aws:iam::085326204011:user/foo",
               create_date: "2018-10-17T13:36:28Z",
               path: "/",
               user_id: "AIDAJMIUVQAU2TW666HH2",
               user_name: "foo",
               tags: []
             }
           },
           response_metadata: %{
             request_id: "a68a2b7c-d211-11e8-9fb2-3f17dd67bd9b"
           }
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "CreateUser")
  end
end
