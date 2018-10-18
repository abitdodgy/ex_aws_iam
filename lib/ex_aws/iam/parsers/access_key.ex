defmodule ExAws.Iam.Parsers.AccessKey do
  @moduledoc """
  Defines parsers for IAM access key query requests.

  """

  import SweetXml, only: [sigil_x: 2]

  @doc """
  Parses the XML response of an IAM `ListAccessKeys` request.

  """
  def list({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//ListAccessKeysResponse",
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
    {:ok, %{resp | body: parsed_body}}
  end
  def list(resp, _), do: resp

  @doc """
  Parses the XML response of an IAM `GetAccessKeyLastUsed` request.

  """
  def get_last_used({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//GetAccessKeyLastUsedResponse",
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
    {:ok, %{resp | body: parsed_body}}
  end
  def get_last_used(resp, _), do: resp

  def create({:ok, %{body: xml, status_code: status} = resp}, _) when status in 200..299 do
    parsed_body =
      xml
      |> SweetXml.xpath(~x"//CreateAccessKeyResponse",
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
    {:ok, %{resp | body: parsed_body}}
  end
  def create(resp, _), do: resp

  defp response_metadata_path do
    [~x"//ResponseMetadata", request_id: ~x"./RequestId/text()"s]
  end
end
