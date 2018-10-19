defmodule ExAws.Iam.Parsers.User do
  @moduledoc """
  Defines parsers for handling AWS IAM `User` query reponses.

  """

  import SweetXml, only: [sigil_x: 2]
  import ExAws.Iam.Utils, only: [response_metadata_path: 0]

  @doc """
  Parses XML from IAM `ListUsers` response.

  """
  def parse(xml, "ListUsers") do
    SweetXml.xpath(xml, ~x"//ListUsersResponse",
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
  end

  @doc """
  Parses XML from IAM `GetUser` response.

  """
  def parse(xml, "GetUser") do
    SweetXml.xpath(xml, ~x"//GetUserResponse",
      get_user_result: [
        ~x"//GetUserResult",
        user: user_path()
      ],
      response_metadata: response_metadata_path()
    )
  end

  @doc """
  Parses XML from IAM `CreateUser` response.

  """
  def parse(xml, "CreateUser") do
    SweetXml.xpath(xml, ~x"//CreateUserResponse",
      create_user_result: [
        ~x"//CreateUserResult",
        user: user_path()
      ],
      response_metadata: response_metadata_path()
    )
  end

  defp user_path do
    [
      ~x"//User",
      path: ~x"./Path/text()"s,
      username: ~x"./UserName/text()"s,
      arn: ~x"./Arn/text()"s,
      user_id: ~x"./UserId/text()"s,
      create_date: ~x"./CreateDate/text()"s
    ]
  end
end
