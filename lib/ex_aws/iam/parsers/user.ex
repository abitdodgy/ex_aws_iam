defmodule ExAws.Iam.Parsers.User do
  @moduledoc """
  Defines parsers for handling AWS IAM `User` query reponses.

  """

  import ExAws.Iam.TestMacro
  import SweetXml, only: [sigil_x: 2]

  defparser(:list_users,
    fields: [
      list_users_result: [
        ~x"//ListUsersResult",
        :is_truncated,
        :marker,
        users: [
          ~x"./Users/member"l,
          :path,
          :user_name,
          :arn,
          :user_id,
          :create_date
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:get_user,
    fields: [
      get_user_result: [
        ~x"//GetUserResult",
        user: [
          ~x"./User",
          :path,
          :user_name,
          :arn,
          :user_id,
          :create_date
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:create_user,
    fields: [
      create_user_result: [
        ~x"//CreateUserResult",
        user: [
          ~x"./User",
          :path,
          :user_name,
          :arn,
          :user_id,
          :create_date
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:update_user,
    fields: [
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:delete_user,
    fields: [
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )
end
