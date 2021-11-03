defmodule ExAws.Iam.Parsers.Certificate do
  import SweetXml, only: [sigil_x: 2]
  import ExAws.Iam.Utils, only: [response_metadata_path: 0, to_boolean: 1]

  @doc """
  Parses XML from IAM `ListServerCertificates` response.
  """
  def parse(xml, "ListServerCertificates") do
    SweetXml.xpath(xml, ~x"//ListServerCertificatesResponse",
      list_server_certificates_result: [
        ~x"//ListServerCertificatesResult",
        is_truncated: ~x"./IsTruncated/text()"s |> to_boolean(),
        marker: ~x"./Marker/text()"s,
        server_certificate_metadata_list: [
          ~x"./ServerCertificateMetadataList/member"l,
          path: ~x"./Path/text()"s,
          server_certificate_name: ~x"./ServerCertificateName/text()"s,
          server_certificate_id: ~x"./ServerCertificateId/text()"s,
          arn: ~x"./Arn/text()"s,
          upload_date: ~x"./UploadDate/text()"s,
          expiration: ~x"./Expiration/text()"s
        ]
      ],
      response_metadata: response_metadata_path()
    )
  end
end
