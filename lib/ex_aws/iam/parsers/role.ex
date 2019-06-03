defmodule ExAws.Iam.Parsers.Role do
  @moduledoc """
  Defines parsers for handling AWS IAM `Role` query reponses.

  """

  import SweetXml, only: [sigil_x: 2]
  import ExAws.Iam.Utils, only: [response_metadata_path: 0]

  @doc """
  Parses XML from IAM `ListRoles` response.

  """
  def parse(xml, "ListRoles") do
    SweetXml.xpath(xml, ~x"//ListRolesResponse",
      list_roles_result: [
        ~x"//ListRolesResult",
        is_truncated: ~x"./IsTruncated/text()"s,
        marker: ~x"./Marker/text()"o,
        roles: [
          ~x"./Roles/member"l,
          path: ~x"./Path/text()"s,
          role_name: ~x"./RoleName/text()"s,
          arn: ~x"./Arn/text()"s,
          role_id: ~x"./RoleId/text()"s,
          create_date: ~x"./CreateDate/text()"s,
          max_session_duration: ~x"./MaxSessionDuration/text()"s,
          assume_role_policy_document:
            ~x"./AssumeRolePolicyDocument/text()"s |> SweetXml.transform_by(&URI.decode/1)
        ]
      ],
      response_metadata: response_metadata_path()
    )
  end

  @doc """
  Parses XML from IAM `ListRoleTags` response.

  """
  def parse(xml, "ListRoleTags") do
    SweetXml.xpath(xml, ~x"//ListRoleTagsResponse",
      list_role_tags_result: [
        ~x"//ListRoleTagsResult",
        is_truncated: ~x"./IsTruncated/text()"s,
        marker: ~x"./Marker/text()"o,
        tags: [
          ~x"./Tags/member"l,
          key: ~x"./Key/text()"s,
          value: ~x"./Value/text()"s
        ]
      ],
      response_metadata: response_metadata_path()
    )
  end
end
