defmodule ExAws.Iam.Parsers.Group do
  @moduledoc """
  Defines parsers for handling AWS IAM `Group` query reponses.

  """

  import SweetXml, only: [sigil_x: 2]
  import ExAws.Iam.Utils, only: [response_metadata_path: 0]

  @doc """
  Parses XML from IAM `CreateGroup` response.

  """
  def parse(xml, "CreateGroup") do
    SweetXml.xpath(xml, ~x"//CreateGroupResponse",
      create_group_result: [
        ~x"//CreateGroupResult",
        group: group_path()
      ],
      response_metadata: response_metadata_path()
    )
  end

  defp group_path do
    [
      ~x"//Group",
      path: ~x"./Path/text()"s,
      group_name: ~x"./GroupName/text()"s,
      arn: ~x"./Arn/text()"s,
      group_id: ~x"./GroupId/text()"s,
      create_date: ~x"./CreateDate/text()"s
    ]
  end
end
