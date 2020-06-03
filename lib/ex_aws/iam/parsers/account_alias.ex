defmodule ExAws.Iam.Parsers.AccountAlias do
  @moduledoc """
  Defines parsers for handling AWS IAM `AccountAlias` query reponses.

  """

  import SweetXml, only: [sigil_x: 2]

  @doc """
  Parses XML from IAM `ListAccountAliases` response.

  """
  def parse(xml, "ListAccountAliases") do
    xml
    |> SweetXml.xpath(~x"//ListAccountAliasesResponse",
      account_aliases: ~x"./ListAccountAliasesResult/AccountAliases/member/text()"sl,
      marker: ~x"./ListAccountAliasesResult/Marker/text()"o,
      is_truncated: ~x"./ListAccountAliasesResult/IsTruncated/text()"s,
      request_id: ~x"./ResponseMetadata/RequestId/text()"s
    )
  end
end
