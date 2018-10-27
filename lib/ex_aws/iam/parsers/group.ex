defmodule ExAws.Iam.Parsers.Group do
  @moduledoc """
  Defines parsers for handling AWS IAM `Group` query reponses.

  """

  import ExAws.Iam.TestMacro
  import SweetXml, only: [sigil_x: 2]

  defparser(:list_groups,
    fields: [
      list_groups_result: [
        ~x"//ListGroupsResult",
        :is_truncated,
        :marker,
        groups: [
          ~x"./Groups/member"l,
          :path,
          :group_name,
          :arn,
          :group_id,
          :create_date
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:get_group,
    fields: [
      get_group_result: [
        ~x"//GetGroupResult",
        group: [
          ~x"./Group",
          :path,
          :group_name,
          :arn,
          :group_id,
          :create_date
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:create_group,
    fields: [
      create_group_result: [
        ~x"//CreateGroupResult",
        group: [
          ~x"./Group",
          :path,
          :group_name,
          :arn,
          :group_id,
          :create_date
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:update_group,
    fields: [
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:delete_group,
    fields: [
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )
end
