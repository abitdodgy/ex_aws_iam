defmodule ExAws.Iam do
  @moduledoc """
  Generates ExAws operations for making IAM API requests.

  You can use the low-level `operation/2` to create any operation.

      iex> ExAws.Iam.operation(:list_users, max_items: 50, path: "/my/path/")
      %ExAws.Operation.Query{
        action: "ListUsers",
        params: %{
          "Action" => "ListUsers",
          "MaxItems" => 50,
          "Path" => "/my/path/",
          "Version" => "2010-05-08"
        },
        parser: &ExAws.Iam.Parser.parse/2,
        path: "/my/path/",
        service: :iam
      }

  You can also use one of the higher-level convenience functions.

      iex> ExAws.Iam.list_users(max_items: 50, path: "/my/path/")
      %ExAws.Operation.Query{
        action: "ListUsers",
        params: %{
          "Action" => "ListUsers",
          "MaxItems" => 50,
          "Path" => "/my/path/",
          "Version" => "2010-05-08"
        },
        parser: &ExAws.Iam.Parser.parse/2,
        path: "/my/path/",
        service: :iam
      }

  Parsers are currently implemented for the following actions:

    * CreateAccessKey
    * CreateGroup
    * CreateUser
    * DeleteAccessKey
    * DeleteGroup
    * DeleteUser
    * GetAccessKeyLastUsed
    * GetGroup
    * GetUser
    * ListAccessKeys
    * ListGroup
    * ListRoles
    * ListRoleTags
    * ListUsers
    * UpdateAccessKey
    * UpdateGroup
    * UpdateUser

  For more information on individual actions, see the AWS
  IAM API documentation.

    * https://docs.aws.amazon.com/IAM/latest/APIReference/API_{OpName}.html

  Replace `OpName` with the name of the operation you want to consult.

  ## Shared Options

    * `:version` - The API version that the request is written for, expressed in the
      format YYYY-MM-DD. Defaults to `2010-05-08`.

    * `:parser` - A function to parse the request. Defaults to `Parser.parse/2`.

  """

  import ExAws.Iam.Utils, only: [list_to_camelized_map: 1, camelize: 1]

  alias ExAws
  alias ExAws.Iam.{AccessKey, Parser, User}

  @shared_opts [version: "2010-05-08"]

  @doc """
  Generates an ExAws operation for the given IAM API action.

  See the AWS IAM API Reference for a list of available actions.

    * https://docs.aws.amazon.com/IAM/latest/APIReference

  ## Parameters

    * `action` - The name of the action you want to call. Should be a _CamelCase_ string.

    * `params` - A keyword list of any params the action takes.

  ## Options

  Any options that the given action

    * `parser` - A function to parse the request result. Defaults
      to `Parser.parser/2`.

  See shared options in moduledoc.

  """
  def operation(action, params, opts \\ []) do
    {parser, params} = Keyword.pop(params, :parser, &Parser.parse/2)
    opts = Keyword.put_new(opts, :parser, parser)

    @shared_opts
    |> Keyword.merge(params)
    |> Keyword.put(:action, camelize(action))
    |> list_to_camelized_map()
    |> to_operation(opts)
  end

  @doc """
  Creates an ExAws operation for a `ListUsers` IAM request.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:path_prefix` - The path prefix for filtering the results.

  See shared options in moduledoc.

  """
  def list_users(opts \\ []) do
    operation(:list_users, opts)
  end

  @doc """
  Creates an ExAws operation for a `GetUser` IAM request.

  ## Parameters

    * `username` - The name of the user to return.

  ## Options

  See shared options in moduledoc.

  """
  def get_user(username, opts \\ []) do
    operation(:get_user, [user_name: username] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `CreateUser` IAM request.

  ## Parameters

    * `username` - The name of the user to create. Must match `[\w+=,.@-]+`.

  ## Options

    * `:path` - The path for the user name. See IAM Identifiers in the IAM User Guide.

    * `:permissions_boundary` - The ARN of the policy that is used to set the
      permissions boundary for the user.

  See shared options in moduledoc.

  """
  def create_user(username, opts \\ []) do
    operation(:create_user, [user_name: username] ++ opts)
  end

  @doc """
  Creates an ExAws operation for an `UpdateUser` IAM request.

  ## Parameters

    * `username` - The name of the user to update. If you're changing the name
      of the user, this is the original user name.

  ## Options

    * `:new_path` - New path for the IAM user. Include this parameter only
      if you're changing the user's path.

    * `:new_user_name` - New name for the user. Include this parameter only
      if you're changing the user's name.

  See shared options in moduledoc.

  """
  def update_user(username, opts \\ []) do
    operation(:update_user, [user_name: username] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `DeleteUser` IAM request.

  ## Parameters

    * `username` - The name of the user to delete.

  ## Options

  See shared options in moduledoc.

  """
  def delete_user(username, opts \\ []) do
    operation(:delete_user, [user_name: username] ++ opts)
  end

  @doc """
  Converts a parsed IAM response into a `User` struct.

  ## Parameters

    * `resp` - The parsed response of an IAM API query request.

  """
  def to_user({:ok, %{body: body}}) do
    User.new(body)
  end

  @doc """
  Creates an ExAws operation for a `ListAccessKeys` IAM request.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:user_name` - Use this parameter to limit the results to the given username.

  See shared options in moduledoc.

  """
  def list_access_keys(opts \\ []) do
    operation(:list_access_keys, opts)
  end

  @doc """
  Creates an ExAws operation for a `GetAccessKeyLastUsed` IAM request.

  ## Parameters

    * `access_key_id` - The identifier of the access key you want to query.

  ## Options

  See shared options in moduledoc.

  """
  def get_access_key_last_used(access_key_id, opts \\ []) do
    operation(:get_access_key_last_used, [access_key_id: access_key_id] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `CreateAccessKey` IAM request.

  ## Parameters

    * `username` - The name of the IAM user that the new key will belong to.

  ## Options

  See shared options in moduledoc.

  """
  def create_access_key(username, opts \\ []) do
    operation(:create_access_key, [user_name: username] ++ opts)
  end

  @doc """
  Creates an ExAws operation for an `UpdateAccessKey` IAM request.

  ## Parameters

    * `access_key_id` - The access key ID you want to update.

    * `status` - The status you want to assign to the secret access key.
      Can be `Active` or `Inactive`.

  ## Options

    * `:user_name` - The name of the user whose access key pair you want to update.

  See shared options in moduledoc.

  """
  def update_access_key(access_key_id, status, opts \\ []) do
    operation(:update_access_key, [access_key_id: access_key_id, status: status] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `DeleteAccessKey` IAM request.

  ## Parameters

    * `access_key_id` - The access key ID you want to delete.

    * `username` - The name of the user whose access key pair you want to delete.

  ## Options

  See shared options in moduledoc.

  """
  def delete_access_key(access_key_id, username, opts \\ []) do
    operation(:delete_access_key, [access_key_id: access_key_id, user_name: username] ++ opts)
  end

  @doc """
  Converts a parsed IAM response into an `AccessKey` struct.

    * `resp` - The parsed response of an IAM API query request.

  """
  def to_access_key({:ok, %{body: body}}) do
    AccessKey.new(body)
  end

  @doc """
  Creates an ExAws operation for a `ListGroups` IAM request.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:path_prefix` - The path prefix for filtering the results.

  See shared options in moduledoc.

  """
  def list_groups(opts \\ []) do
    operation(:list_groups, opts)
  end

  @doc """
  Creates an ExAws operation for a `GetGroup` IAM request.

  ## Parameters

    * `name` - The name of the group to return.

  ## Options

  See shared options in moduledoc.

  """
  def get_group(name, opts \\ []) do
    operation(:get_group, [group_name: name] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `CreateGroup` IAM request.

  ## Parameters

    * `name` - The name of the IAM group to create.

  ## Options

    * `:path` - The path to the group. Defaults to "/".

  See shared options in moduledoc.

  """
  def create_group(name, opts \\ []) do
    operation(:create_group, [group_name: name] ++ opts)
  end

  @doc """
  Creates an ExAws operation for an `UpdateGroup` IAM request.

  ## Parameters

    * `name` - The name of the group to update. If you're changing the name
      of the group, this is the original group name.

  ## Options

    * `:new_path` - New path for the IAM group. Include this parameter only
      if you're changing the group's path.

    * `:new_group_name` - New name for the group. Include this parameter only
      if you're changing the group's name.

  See shared options in moduledoc.

  """
  def update_group(name, opts \\ []) do
    operation(:update_group, [group_name: name] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `DeleteGroup` IAM request.

  ## Parameters

    * `name` - The name of the group to delete.

  ## Options

  See shared options in moduledoc.

  """
  def delete_group(name, opts \\ []) do
    operation(:delete_group, [group_name: name] ++ opts)
  end

  @doc """
  Creates an ExAws operation for a `ListRoles` IAM request.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:path_prefix` - The path prefix for filtering the results.

  See shared options in moduledoc.

  """
  def list_roles(opts \\ []) do
    operation(:list_roles, opts)
  end

  @doc """
  Creates an ExAws operation for a `ListRoleTags` IAM request.

  ## Parameters

    * `role_name` - The name of the role to return for which you want to get the list of tags.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:path_prefix` - The path prefix for filtering the results.

  See shared options in moduledoc.

  """
  def list_role_tags(role_name, opts \\ []) do
    operation(:list_role_tags, [role_name: role_name] ++ opts)
  end

  def list_server_certificates(opts \\ []) do
    operation(:list_server_certificates, opts)
  end

  defp to_operation(params, opts) do
    %ExAws.Operation.Query{
      action: params["Action"],
      params: params,
      parser: Keyword.get(opts, :parser),
      path: params["Path"] || "/",
      service: :iam
    }
  end
end
