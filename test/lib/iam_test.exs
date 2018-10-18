defmodule ExAws.IamTest do
  use ExUnit.Case
  doctest ExAws.Iam

  alias ExAws.Iam
  alias ExAws.Iam.Parsers

  test "list_users/0 returns an ExAws ListUsers op struct" do
    opts = [
      marker: "abc",
      max_items: 50,
      path_prefix: "/prefix"
    ]
    expected =
      %ExAws.Operation.Query{
        action: "ListUsers",
        params: %{
          "Action" => "ListUsers",
          "Marker" => "abc",
          "MaxItems" => 50,
          "PathPrefix" => "/prefix",
          "Version" => "2010-05-08"
        },
        parser: &Parsers.User.list/2,
        path: "/",
        service: :iam
      }
    assert Iam.list_users(opts) == expected
  end

  test "get_user/1 returns an ExAws GetUser op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "GetUser",
        params: %{
          "Action" => "GetUser",
          "UserName" => "foo",
          "Version" => "2010-05-08"
        },
        parser: &ExAws.Iam.Parsers.User.get/2,
        path: "/",
        service: :iam
      }
    assert Iam.get_user("foo") == expected
  end

  test "create_user/1 returns an ExAws CreateUser op struct" do
    opts = [
      path: "/my/path",
      permissions_boundary: "foo"
    ]
    expected =
      %ExAws.Operation.Query{
        action: "CreateUser",
        params: %{
          "Action" => "CreateUser",
          "Path" => "/my/path",
          "PermissionsBoundary" => "foo",
          "UserName" => "mo",
          "Version" => "2010-05-08"
        },
        parser: &Parsers.User.create/2,
        path: "/my/path",
        service: :iam
      }
    assert Iam.create_user("mo", opts) == expected
  end

  test "update_user/1 returns an ExAws UpdateUser op struct" do
    opts = [
      new_path: "/new/path",
      new_username: "new"
    ]

    expected =
      %ExAws.Operation.Query{
        action: "UpdateUser",
        params: %{
          "Action" => "UpdateUser",
          "NewPath" => "/new/path",
          "NewUserName" => "new",
          "UserName" => "mo",
          "Version" => "2010-05-08"
        },
        parser: nil,
        path: "/",
        service: :iam
      }
    assert Iam.update_user("mo", opts) == expected
  end

  test "delete_user/1 returns an ExAws DeleteUser op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "DeleteUser",
        params: %{
          "Action" => "DeleteUser",
          "UserName" => "mo",
          "Version" => "2010-05-08"
        },
        parser: nil,
        path: "/",
        service: :iam
      }
    assert Iam.delete_user("mo") == expected
  end

  test "list_access_keys/0 returns an ExAws ListAccessKeys op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "ListAccessKeys",
        params: %{
          "Action" => "ListAccessKeys",
          "Version" => "2010-05-08"
        },
        parser: &Parsers.AccessKey.list/2,
        path: "/",
        service: :iam
      }
    assert Iam.list_access_keys() == expected
  end

  test "get_access_key_last_used/1 returns an ExAws GetAccessKeyLastUsed op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "GetAccessKeyLastUsed",
        params: %{
          "AccessKeyId" => "key",
          "Action" => "GetAccessKeyLastUsed",
          "Version" => "2010-05-08"
        },
        parser: &Parsers.AccessKey.get_last_used/2,
        path: "/",
        service: :iam
      }
    assert Iam.get_access_key_last_used("key") == expected
  end

  test "create_access_key/1 returns an ExAws CreateAccessKey op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "CreateAccessKey",
        params: %{
          "Action" => "CreateAccessKey",
          "UserName" => "username",
          "Version" => "2010-05-08"
        },
        parser: &Parsers.AccessKey.create/2,
        path: "/",
        service: :iam
      }
    assert Iam.create_access_key("username") == expected
  end

  test "update_access_key/1 returns an ExAws UpdateAccessKey op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "UpdateAccessKey",
        params: %{
          "AccessKeyId" => "key_id",
          "Action" => "UpdateAccessKey",
          "Status" => "username",
          "Version" => "2010-05-08"
        },
        parser: nil,
        path: "/",
        service: :iam
      }
    assert Iam.update_access_key("key_id", "username") == expected
  end

  test "delete_access_key/1 returns an ExAws DeleteAccessKey op struct" do
    expected =
      %ExAws.Operation.Query{
        action: "DeleteAccessKey",
        params: %{
          "AccessKeyId" => "key_id",
          "Action" => "DeleteAccessKey",
          "UserName" => "username",
          "Version" => "2010-05-08"
        },
        parser: nil,
        path: "/",
        service: :iam
      }
    assert Iam.delete_access_key("key_id", "username") == expected
  end
end
