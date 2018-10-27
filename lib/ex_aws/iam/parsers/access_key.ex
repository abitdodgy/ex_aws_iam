defmodule ExAws.Iam.Parsers.AccessKey do
  @moduledoc """
  Defines parsers for handling AWS IAM `AccessKey` query reponses.

  """

  import ExAws.Iam.TestMacro
  import SweetXml, only: [sigil_x: 2]

  defparser(:list_access_keys,
    fields: [
      list_access_keys_result: [
        ~x"//ListAccessKeysResult",
        :is_truncated,
        :marker,
        access_key_metadata: [
          ~x"./AccessKeyMetadata/member"l,
          :access_key_id,
          :create_date,
          :user_name,
          :status
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:get_access_key_last_used,
    fields: [
      get_access_key_last_used_result: [
        ~x"//GetAccessKeyLastUsedResult",
        {:access_key_last_used,
         [
           ~x"./AccessKeyLastUsed",
           :last_used_date,
           :region,
           :service_name
         ]},
        :user_name
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:create_access_key,
    fields: [
      create_access_key_result: [
        ~x"//CreateAccessKeyResult",
        access_key: [
          ~x"./AccessKey",
          :access_key_id,
          :secret_access_key,
          :access_key_selector,
          :user_name,
          :create_date,
          :status
        ]
      ],
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:update_access_key,
    fields: [
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )

  defparser(:delete_access_key,
    fields: [
      response_metadata: [
        ~x"//ResponseMetadata",
        :request_id
      ]
    ]
  )
end
