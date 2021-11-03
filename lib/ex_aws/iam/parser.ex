defmodule ExAws.Iam.Parser do
  @moduledoc """
  An interface for parsing IAM user query responses.

  To add a new parser, define a `parse/2` function in the desired
  module and add the action name to the corresponding @x_actions list.

  The first argument should be the XML response body and the
  second the name of the operation.

  """

  alias ExAws.Iam.Parsers.{
    AccessKey,
    Certificate,
    Group,
    Metadata,
    Role,
    User
  }

  @doc """
  Parses XML from IAM API query responses.

  """
  def parse({:ok, %{body: xml, status_code: status} = resp}, action) when status in 200..299 do
    parsed_body = dispatch(xml, action)
    {:ok, %{resp | body: parsed_body}}
  end

  def parse(resp, _), do: resp

  @user_actions ~w[
    ListUsers
    GetUser
    CreateUser
  ]

  defp dispatch(xml, action) when action in @user_actions do
    User.parse(xml, action)
  end

  @access_key_actions ~w[
    ListAccessKeys
    GetAccessKeyLastUsed
    CreateAccessKey
  ]

  defp dispatch(xml, action) when action in @access_key_actions do
    AccessKey.parse(xml, action)
  end

  @group_actions ~w[
    ListGroups
    GetGroup
    CreateGroup
  ]

  defp dispatch(xml, action) when action in @group_actions do
    Group.parse(xml, action)
  end

  @role_actions ~w[
    ListRoles
    ListRoleTags
  ]

  defp dispatch(xml, action) when action in @role_actions do
    Role.parse(xml, action)
  end

  @metadata_only_actions ~w[
    UpdateAccessKey
    UpdateGroup
    UpdateUser
    DeleteAccessKey
    DeleteGroup
    DeleteUser
  ]

  defp dispatch(xml, action) when action in @metadata_only_actions do
    Metadata.parse(xml, action)
  end

  @certificate_actions ~w[
    ListServerCertificates
  ]

  defp dispatch(xml, action) when action in @certificate_actions do
    Certificate.parse(xml, action)
  end
end
