defmodule ExAws.Iam.Parsers.User do
  @moduledoc """
  Defines parsers for IAM user query requests.

  """

  import SweetXml, only: [sigil_x: 2]

  @doc """
  Parses the XML response of an IAM `ListUsers` request.

  """
  def list({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//ListUsersResponse",
        list_users_result: [
          ~x"//ListUsersResult",
          is_truncated: ~x"./IsTruncated/text()"s,
          marker: ~x"./Marker/text()"o,
          users: [
            ~x"./Users/member"l,
            path: ~x"./Path/text()"s,
            username: ~x"./UserName/text()"s,
            arn: ~x"./Arn/text()"s,
            user_id: ~x"./UserId/text()"s,
            create_date: ~x"./CreateDate/text()"s
          ]
        ],
        response_metadata: response_metadata_path()
      )
    {:ok, %{resp | body: parsed_body}}
  end
  def list(resp, _), do: resp

  @doc """
  Parses the XML response of an IAM `GetUser` request.

  """
  def get({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//GetUserResponse",
        get_user_result: [
          ~x"//GetUserResult", user: user_path()
        ],
        response_metadata: response_metadata_path()
      )
    {:ok, %{resp | body: parsed_body}}
  end
  def get(resp, _), do: resp

  @doc """
  Parses the XML response of an IAM `CreateUser` request.

  """
  def create({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//CreateUserResponse",
        create_user_result: [
          ~x"//CreateUserResult", user: user_path()
        ],
        response_metadata: response_metadata_path()
      )
    {:ok, %{resp | body: parsed_body}}
  end
  def create(resp, _), do: resp

  @doc """
  Parses the XML response of an IAM `UpdateUser` request.

  """
  def update({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//UpdateUserResponse",
        response_metadata: response_metadata_path()
      )
    {:ok, %{resp | body: parsed_body}}
  end
  def update(resp, _), do: resp

  @doc """
  Parses the XML response of an IAM `DeleteUser` request.

  """
  def delete({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//DeleteUserResponse",
        response_metadata: response_metadata_path()
      )
    {:ok, %{resp | body: parsed_body}}
  end
  def delete(resp, _), do: resp

  defp user_path do
    [~x"//User",
      path: ~x"./Path/text()"s,
      username: ~x"./UserName/text()"s,
      arn: ~x"./Arn/text()"s,
      user_id: ~x"./UserId/text()"s,
      create_date: ~x"./CreateDate/text()"s]
  end

  defp response_metadata_path do
    [~x"//ResponseMetadata", request_id: ~x"./RequestId/text()"s]
  end
end
