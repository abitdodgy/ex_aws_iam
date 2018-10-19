defmodule ExAws.IamTest do
  use ExUnit.Case
  doctest ExAws.Iam

  import ExAws.Iam.TestHelper, only: [read_file: 2]

  alias ExAws.Iam
  alias ExAws.Iam.{AccessKey, Parser, User}

  describe "User" do
    test "list_users/0 returns an ExAws ListUsers op struct" do
      opts = [
        marker: "abc",
        max_items: 50,
        path_prefix: "/prefix"
      ]

      expected = %ExAws.Operation.Query{
        action: "ListUsers",
        params: %{
          "Action" => "ListUsers",
          "Marker" => "abc",
          "MaxItems" => 50,
          "PathPrefix" => "/prefix",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.list_users(opts) == expected
    end

    test "get_user/1 returns an ExAws GetUser op struct" do
      expected = %ExAws.Operation.Query{
        action: "GetUser",
        params: %{
          "Action" => "GetUser",
          "UserName" => "foo",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
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

      expected = %ExAws.Operation.Query{
        action: "CreateUser",
        params: %{
          "Action" => "CreateUser",
          "Path" => "/my/path",
          "PermissionsBoundary" => "foo",
          "UserName" => "mo",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/my/path",
        service: :iam
      }

      assert Iam.create_user("mo", opts) == expected
    end

    test "update_user/1 returns an ExAws UpdateUser op struct" do
      opts = [
        new_path: "/new/path",
        new_user_name: "new"
      ]

      expected = %ExAws.Operation.Query{
        action: "UpdateUser",
        params: %{
          "Action" => "UpdateUser",
          "NewPath" => "/new/path",
          "NewUserName" => "new",
          "UserName" => "mo",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.update_user("mo", opts) == expected
    end

    test "delete_user/1 returns an ExAws DeleteUser op struct" do
      expected = %ExAws.Operation.Query{
        action: "DeleteUser",
        params: %{
          "Action" => "DeleteUser",
          "UserName" => "mo",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.delete_user("mo") == expected
    end

    test "to_user/1 converts GetUser result into a User struct" do
      xml = read_file("user", "get")
      response = Parser.parse({:ok, %{body: xml, status_code: 200}}, "GetUser")

      {:ok,
       %{
         body: %{
           get_user_result: %{
             user: user
           }
         }
       }} = response

      assert Iam.to_user(response) ==
               %User{
                 arn: user[:arn],
                 create_date: user[:create_date],
                 path: user[:path],
                 username: user[:username],
                 user_id: user[:user_id]
               }
    end

    test "to_user/1 converts CreateUser result into a User struct" do
      xml = read_file("user", "create")
      response = Parser.parse({:ok, %{body: xml, status_code: 200}}, "CreateUser")

      {:ok,
       %{
         body: %{
           create_user_result: %{
             user: user
           }
         }
       }} = response

      assert Iam.to_user(response) ==
               %User{
                 arn: user[:arn],
                 create_date: user[:create_date],
                 path: user[:path],
                 username: user[:username],
                 user_id: user[:user_id]
               }
    end

    test "to_user/1 converts ListUsers result into a list of User structs" do
      xml = read_file("user", "list")
      response = Parser.parse({:ok, %{body: xml, status_code: 200}}, "ListUsers")

      {:ok,
       %{
         body: %{
           list_users_result: %{
             users: [user, user_2]
           }
         }
       }} = response

      assert Iam.to_user(response) == [
               %User{
                 arn: user[:arn],
                 create_date: user[:create_date],
                 path: user[:path],
                 username: user[:username],
                 user_id: user[:user_id]
               },
               %User{
                 arn: user_2[:arn],
                 create_date: user_2[:create_date],
                 path: user_2[:path],
                 user_id: user_2[:user_id],
                 username: user_2[:username]
               }
             ]
    end
  end

  describe "AccessKey" do
    test "list_access_keys/0 returns an ExAws ListAccessKeys op struct" do
      expected = %ExAws.Operation.Query{
        action: "ListAccessKeys",
        params: %{
          "Action" => "ListAccessKeys",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.list_access_keys() == expected
    end

    test "get_access_key_last_used/1 returns an ExAws GetAccessKeyLastUsed op struct" do
      expected = %ExAws.Operation.Query{
        action: "GetAccessKeyLastUsed",
        params: %{
          "AccessKeyId" => "key",
          "Action" => "GetAccessKeyLastUsed",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.get_access_key_last_used("key") == expected
    end

    test "create_access_key/1 returns an ExAws CreateAccessKey op struct" do
      expected = %ExAws.Operation.Query{
        action: "CreateAccessKey",
        params: %{
          "Action" => "CreateAccessKey",
          "UserName" => "username",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.create_access_key("username") == expected
    end

    test "update_access_key/1 returns an ExAws UpdateAccessKey op struct" do
      expected = %ExAws.Operation.Query{
        action: "UpdateAccessKey",
        params: %{
          "AccessKeyId" => "key_id",
          "Action" => "UpdateAccessKey",
          "Status" => "username",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.update_access_key("key_id", "username") == expected
    end

    test "delete_access_key/1 returns an ExAws DeleteAccessKey op struct" do
      expected = %ExAws.Operation.Query{
        action: "DeleteAccessKey",
        params: %{
          "AccessKeyId" => "key_id",
          "Action" => "DeleteAccessKey",
          "UserName" => "username",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.delete_access_key("key_id", "username") == expected
    end

    test "to_access_key/1 converts ListAccessKeys result into a list of AccessKey structs" do
      xml = read_file("access_key", "list")
      response = Parser.parse({:ok, %{body: xml, status_code: 200}}, "ListAccessKeys")

      {:ok,
       %{
         body: %{
           list_access_keys_result: %{
             access_key_metadata: [access_key]
           }
         }
       }} = response

      assert Iam.to_access_key(response) == [
               %AccessKey{
                 access_key_id: access_key[:access_key_id],
                 access_key_selector: access_key[:access_key_selector],
                 create_date: access_key[:create_date],
                 secret_access_key: access_key[:secret_access_key],
                 status: access_key[:status],
                 username: access_key[:username]
               }
             ]
    end

    test "to_access_key/1 converts CreateAccessKey result into an AccessKey struct" do
      xml = read_file("access_key", "create")
      response = Parser.parse({:ok, %{body: xml, status_code: 200}}, "CreateAccessKey")

      {:ok,
       %{
         body: %{
           create_access_key_result: %{
             access_key: access_key
           }
         }
       }} = response

      assert Iam.to_access_key(response) ==
               %AccessKey{
                 access_key_id: access_key[:access_key_id],
                 access_key_selector: access_key[:access_key_selector],
                 create_date: access_key[:create_date],
                 secret_access_key: access_key[:secret_access_key],
                 status: access_key[:status],
                 username: access_key[:username]
               }
    end
  end

  describe "Group" do
    test "create_group/1 returns an ExAws CreateGroup op struct" do
      opts = [
        path: "/my/path"
      ]

      expected = %ExAws.Operation.Query{
        action: "CreateGroup",
        params: %{
          "Action" => "CreateGroup",
          "Path" => "/my/path",
          "GroupName" => "my_group",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/my/path",
        service: :iam
      }

      assert Iam.create_group("my_group", opts) == expected
    end

    test "update_group/1 returns an ExAws UpdateGroup op struct" do
      opts = [
        new_path: "/new/path",
        new_group_name: "new_group_name"
      ]

      expected = %ExAws.Operation.Query{
        action: "UpdateGroup",
        params: %{
          "Action" => "UpdateGroup",
          "NewPath" => "/new/path",
          "NewGroupName" => "new_group_name",
          "GroupName" => "my_group",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.update_group("my_group", opts) == expected
    end

    test "delete_group/1 returns an ExAws DeleteGroup op struct" do
      expected = %ExAws.Operation.Query{
        action: "DeleteGroup",
        params: %{
          "Action" => "DeleteGroup",
          "GroupName" => "my_group",
          "Version" => "2010-05-08"
        },
        parser: &Parser.parse/2,
        path: "/",
        service: :iam
      }

      assert Iam.delete_group("my_group") == expected
    end
  end
end
