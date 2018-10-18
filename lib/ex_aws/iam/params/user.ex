defmodule ExAws.Iam.Params.User do
  @moduledoc """
  Generates query params for working with IAM users.

  """

  import ExAws.Iam.Utils, only: [opts_to_params: 2]

  @actions_map %{
    list: "ListUsers",
    get: "GetUser",
    create: "CreateUser",
    update: "UpdateUser",
    delete: "DeleteUser"
  }

  @params_map %{
    action: "Action",
    marker: "Marker",
    max_items: "MaxItems",
    new_path: "NewPath",
    new_username: "NewUserName",
    path: "Path",
    path_prefix: "PathPrefix",
    permissions_boundary: "PermissionsBoundary",
    username: "UserName",
    version: "Version"
  }

  @shared_params ~w[action version]a

  @doc """
  Generates query params for an IAM request for given action.

  ## Parameters

    * `action` - The action name to generate params for.

  ## Options

  A list of options to to supply for the given action.

  """
  def new(action, opts \\ []) do
    opts = Keyword.put(opts, :action, Map.get(@actions_map, action))
    params = params_for(action) ++ @shared_params
    @params_map
    |> Map.take(params)
    |> opts_to_params(opts)
  end

  @list_params ~w[marker max_items path_prefix]a
  defp params_for(:list), do: @list_params

  @get_params ~w[username]a
  defp params_for(:get), do: @get_params

  @create_params ~w[path permissions_boundary username]a
  defp params_for(:create), do: @create_params

  @update_params ~w[new_username new_path username]a
  defp params_for(:update), do: @update_params

  @delete_params ~w[username]a
  defp params_for(:delete), do: @delete_params
end
