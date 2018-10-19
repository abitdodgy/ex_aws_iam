defmodule ExAws.Iam.Parsers.User do
  @moduledoc """
  Defines parsers for handling AWS IAM user query reponses.

  """

  import SweetXml, only: [sigil_x: 2]

  @doc """
  Parses XML from IAM API user query responses.

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

  def parse(xml, "GetUser") do    
    SweetXml.xpath(xml, ~x"//GetUserResponse",
      get_user_result: [
        ~x"//GetUserResult",
        user: user_path()
      ],
      response_metadata: response_metadata_path()
    )
  end

  def parse(xml, "CreateUser") do
    SweetXml.xpath(xml, ~x"//CreateUserResponse",
      create_user_result: [
        ~x"//CreateUserResult",
        user: user_path()
      ],
      response_metadata: response_metadata_path()
    )
  end

  def parse(xml, action) when action in ~w[UpdateUser DeleteUser] do
    path = "//" <> action <> "Response"
    SweetXml.xpath(xml, ~x"#{path}",
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

  defp response_metadata_path do
    [~x"//ResponseMetadata", request_id: ~x"./RequestId/text()"s]
  end
end
