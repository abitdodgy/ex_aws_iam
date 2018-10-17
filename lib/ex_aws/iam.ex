defmodule ExAws.Iam do
  @moduledoc """
  Creates ExAws operations for making IAM requests.

  ## Shared Options

    * `:version` - The API version that the request is written for, expressed in the
      format YYYY-MM-DD. Defaults to `2010-05-08`.

  """  

  alias ExAws
  alias ExAws.Iam.{Parsers, Params}

  @doc """
  Creates an ExAws operation for a [`ListUsers`][1] IAM request.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:path_prefix` - The path prefix for filtering the results.

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListUsers.html

  """
  def list_users(opts \\ []) do
    :list
    |> Params.User.new(opts)
    |> to_op(parser: &Parsers.User.list/2)
  end

  @doc """
  Creates an ExAws operation for a [`CreateUser`][1] IAM request.

  ## Parameters

    * `username` - The name of the user to create. Must match `[\w+=,.@-]+`.

  ## Options

    * `:path` - The path for the user name. See IAM Identifiers in the IAM User Guide.

    * `:permissions_boundary` - The ARN of the policy that is used to set the
      permissions boundary for the user.

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateUser.html

  """
  def create_user(username, opts \\ []) do
    :create
    |> Params.User.new([username: username] ++ opts)
    |> to_op(parser: &Parsers.User.create/2)
  end

  @doc """
  Creates an ExAws operation for an [`UpdateUser`][1] IAM request.

  ## Parameters

    * `username` - The name of the user to update. If you're changing the name
      of the user, this is the original user name.

  ## Options

    * `:new_path` - New path for the IAM user. Include this parameter only
      if you're changing the user's path.

    * `:new_username` - New name for the user. Include this parameter only
      if you're changing the user's name.

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateUser.html

  """
  def update_user(username, opts \\ []) do
    :update
    |> Params.User.new([username: username] ++ opts)
    |> to_op()
  end

  @doc """
  Creates an ExAws operation for a [`DeleteUser`][1] IAM request.

  ## Parameters

    * `username` - The name of the user to delete.

  ## Options

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteUser.html

  """
  def delete_user(username, opts \\ []) do
    :delete
    |> Params.User.new([username: username] ++ opts)
    |> to_op()
  end

  @doc """
  Creates an ExAws operation for a [`ListAccessKeys`][1] IAM request.

  ## Options

    * `:marker` - Use this parameter only when paginating results.

    * `:max_items` - Use this only when paginating results to indicate
      the maximum number of items you want in the response.

    * `:username` - Use this parameter to limit the results to the given username.

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListAccessKeys.html

  """
  def list_access_keys(opts \\ []) do
    :list
    |> Params.AccessKey.new(opts)
    |> to_op(parser: &Parsers.AccessKey.list/2)
  end

  @doc """
  Creates an ExAws operation for a [`GetAccessKeyLastUsed`][1] IAM request.

  ## Parameters

    * `access_key_id` - The identifier of the access key you want to query.

  ## Options

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccessKeyLastUsed.html

  """
  def get_access_key_last_used(access_key_id, opts \\ []) do
    :get_last_used
    |> Params.AccessKey.new([access_key_id: access_key_id] ++ opts)
    |> to_op(parser: &Parsers.AccessKey.get_last_used/2)
  end

  @doc """
  Creates an ExAws operation for a [`CreateAccessKey`][1] IAM request.

  ## Parameters

    * `username` - The name of the IAM user that the new key will belong to.

  ## Options

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateAccessKey.html

  """
  def create_access_key(username, opts \\ []) do
    :create
    |> Params.AccessKey.new([username: username] ++ opts)
    |> to_op(parser: &Parsers.AccessKey.create/2)
  end  

  @doc """
  Creates an ExAws operation for an [`UpdateAccessKey`][1] IAM request.

  ## Parameters

    * `access_key_id` - The access key ID you want to update.

    * `status` - The status you want to assign to the secret access key.
      Can be `Active` or `Inactive`.

  ## Options

    * `:username` - The name of the user whose access key pair you want to update.

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_UpdateAccessKey.html

  """
  def update_access_key(access_key_id, status, opts \\ []) do
    opts = [access_key_id: access_key_id, status: status] ++ opts
    :update
    |> Params.AccessKey.new(opts)
    |> to_op()
  end

  @doc """
  Creates an ExAws operation for a [`DeleteAccessKey`][1] IAM request.

  ## Parameters

    * `access_key_id` - The access key ID you want to delete.

    * `username` - The name of the user whose access key pair you want to delete.

  ## Options

  See shared options in moduledoc.

  [1] https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteAccessKey.html

  """
  def delete_access_key(access_key_id, username, opts \\ []) do
    opts = [access_key_id: access_key_id, username: username] ++ opts
    :delete
    |> Params.AccessKey.new(opts)
    |> to_op()
  end

  defp to_op(params, opts \\ []) do
    params = Map.merge(%{
      "Version" => "2010-05-08"
    }, params)
    %ExAws.Operation.Query{
      action: params["Action"],
      params: params,
      parser: Keyword.get(opts, :parser),
      path: params["Path"] || "/",
      service: :iam
    }
  end
end
