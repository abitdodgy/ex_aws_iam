defmodule ExAws.Iam.Parsers.UserTest do
  use ExUnit.Case
  doctest ExAws.Iam.Parsers.User

  alias ExAws.Iam.Parsers

  test "list/2" do
    xml = read_file("list")
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
                 username: "bar"
               },
               %{
                 arn: "arn:aws:iam::085326204011:user/some_user",
                 create_date: "2018-10-14T18:31:50Z",
                 path: "/",
                 user_id: "AIDAJZTLCIRAWNUUPBREC",
                 username: "some_user"
               }
             ]
           },
           response_metadata: %{request_id: "25c67fa6-d212-11e8-b8d6-a7951e68fc2c"}
         },
         status_code: 200
       }}

    assert expected == Parsers.User.list(response, "ListUsers")
  end

  test "get/2" do
    xml = read_file("get")
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
               username: "foo"
             }
           },
           response_metadata: %{request_id: "21a662e8-d27c-11e8-921e-e7a12b78bc94"}
         },
         status_code: 200
       }}

    assert expected == Parsers.User.get(response, "GetUser")
  end

  test "create/2" do
    xml = read_file("create")
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
               username: "foo"
             }
           },
           response_metadata: %{
             request_id: "a68a2b7c-d211-11e8-9fb2-3f17dd67bd9b"
           }
         },
         status_code: 200
       }}

    assert expected == Parsers.User.create(response, "CreateUser")
  end

  test "update/2" do
    xml = read_file("update")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           response_metadata: %{
             request_id: "95dc0a83-d212-11e8-adf2-fb1dda9ce0ce"
           }
         },
         status_code: 200
       }}

    assert expected == Parsers.User.update(response, "DeleteUser")
  end

  test "delete/2" do
    xml = read_file("delete")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           response_metadata: %{
             request_id: "ccad8c35-d212-11e8-bd77-49651db80edb"
           }
         },
         status_code: 200
       }}

    assert expected == Parsers.User.delete(response, "DeleteUser")
  end

  defp read_file(name) do
    File.read!("test/support/responses/user/#{name}.xml")
  end
end
