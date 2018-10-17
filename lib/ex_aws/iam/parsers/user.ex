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
      |> SweetXml.xpath(~x"//ListUsersResult",
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
      |> SweetXml.xpath(~x"//GetUserResult/User",
        path: ~x"./Path/text()"s,
        username: ~x"./UserName/text()"s,
        arn: ~x"./Arn/text()"s,
        user_id: ~x"./UserId/text()"s,
        create_date: ~x"./CreateDate/text()"s
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
      |> SweetXml.xpath(~x"//CreateUserResult/User",
        path: ~x"./Path/text()"s,
        username: ~x"./UserName/text()"s,
        arn: ~x"./Arn/text()"s,
        user_id: ~x"./UserId/text()"s,
        create_date: ~x"./CreateDate/text()"s
      )
    {:ok, %{resp | body: parsed_body}}
  end

  def create(resp, _), do: resp
end
