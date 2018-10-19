defmodule ExAws.Iam.Parsers.AccessKeyTest do
  use ExUnit.Case

  import ExAws.Iam.TestHelper, only: [read_file: 2]

  alias ExAws.Iam.Parser

  test "list/2" do
    xml = read_file("access_key", "list")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           list_access_keys_result: %{
             access_key_metadata: [
               %{
                 access_key_id: "AKIAIUOHJT6CXCJW43DQ",
                 create_date: "2018-10-16T23:58:20Z",
                 status: "Active",
                 username: "foo"
               }
             ],
             is_truncated: "false",
             marker: nil
           },
           response_metadata: %{request_id: "f4db0a12-d212-11e8-a23b-47700e6bdeb6"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "ListAccessKeys")
  end

  test "get_last_used/2" do
    xml = read_file("access_key", "get_last_used")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           get_access_key_last_used_result: %{
             access_key_last_used: %{
               last_used_date: "2018-10-17T13:43:00Z",
               region: "us-east-1",
               service_name: "iam"
             },
             username: "some_user"
           },
           response_metadata: %{request_id: "523b4eec-d213-11e8-a831-bf9f1ef556f4"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "GetAccessKeyLastUsed")
  end

  test "create/2" do
    xml = read_file("access_key", "create")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           create_access_key_result: %{
             access_key: %{
               access_key_id: "AKIAJMQYDBOGSEDSCLJA",
               access_key_selector: "HMAC",
               create_date: "2018-10-17T13:50:19Z",
               secret_access_key: "WfDYxMvaYbDj+VO87DHAwzzW3rQDifiFzej7Z5a0",
               status: "Active",
               username: "foo"
             }
           },
           response_metadata: %{request_id: "95e4040f-d213-11e8-9c4e-3b1e4516a97d"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "CreateAccessKey")
  end

  test "update/2" do
    xml = read_file("access_key", "update")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           response_metadata: %{request_id: "fea09bbb-d213-11e8-bd77-49651db80edb"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "UpdateAccessKey")
  end

  test "delete/2" do
    xml = read_file("access_key", "delete")
    response = {:ok, %{body: xml, status_code: 200}}

    expected =
      {:ok,
       %{
         body: %{
           response_metadata: %{request_id: "83a816bf-d214-11e8-ae70-8d0f09bb39be"}
         },
         status_code: 200
       }}

    assert expected == Parser.parse(response, "DeleteAccessKey")
  end
end
