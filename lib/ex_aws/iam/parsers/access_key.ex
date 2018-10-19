defmodule ExAws.Iam.Parsers.AccessKey do
  @moduledoc """
  Defines parsers for handling AWS IAM `AccessKey` query reponses.

  """

  import SweetXml, only: [sigil_x: 2]
  import ExAws.Iam.Utils, only: [response_metadata_path: 0]

  @doc """
  Parses XML from IAM `ListAccessKeys` response.

  """
  def parse(xml, "ListAccessKeys") do
    SweetXml.xpath(xml, ~x"//ListAccessKeysResponse",
      list_access_keys_result: [
        ~x"//ListAccessKeysResult",
        is_truncated: ~x"./IsTruncated/text()"s,
        marker: ~x"./Marker/text()"o,
        access_key_metadata: [
          ~x"./AccessKeyMetadata/member"l,
          access_key_id: ~x"./AccessKeyId/text()"s,
          username: ~x"./UserName/text()"s,
          create_date: ~x"./CreateDate/text()"s,
          status: ~x"./Status/text()"s
        ]
      ],
      response_metadata: response_metadata_path()
    )
  end

  @doc """
  Parses XML from IAM `GetAccessKeyLastUsed` response.

  """
  def parse(xml, "GetAccessKeyLastUsed") do
    SweetXml.xpath(xml, ~x"//GetAccessKeyLastUsedResponse",
      get_access_key_last_used_result: [
        ~x"//GetAccessKeyLastUsedResult",
        access_key_last_used: [
          ~x"//AccessKeyLastUsed",
          last_used_date: ~x"./LastUsedDate/text()"s,
          region: ~x"./Region/text()"s,
          service_name: ~x"./ServiceName/text()"s
        ],
        username: ~x"./UserName/text()"s
      ],
      response_metadata: response_metadata_path()
    )
  end

  @doc """
  Parses XML from IAM `CreateAccessKey` response.

  """
  def parse(xml, "CreateAccessKey") do
    SweetXml.xpath(xml, ~x"//CreateAccessKeyResponse",
      create_access_key_result: [
        ~x"//CreateAccessKeyResult",
        access_key: [
          ~x"//AccessKey",
          access_key_id: ~x"./AccessKeyId/text()"s,
          secret_access_key: ~x"./SecretAccessKey/text()"s,
          access_key_selector: ~x"./AccessKeySelector/text()"s,
          username: ~x"./UserName/text()"s,
          create_date: ~x"./CreateDate/text()"s,
          status: ~x"./Status/text()"s
        ]
      ],
      response_metadata: response_metadata_path()
    )
  end
end
