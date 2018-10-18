defmodule ExAws.Iam.AccessKey do
  @moduledoc """
  A struct that represents an IAM access key.

  """

  @enforce_keys ~w[
    access_key_id
    access_key_selector
    create_date
    secret_access_key
    status
    username
  ]a

  defstruct access_key_id: nil, access_key_selector: nil, create_date: nil,
    secret_access_key: nil, status: nil, username: nil

  @type t :: %ExAws.Iam.AccessKey{
    access_key_id: String.t,
    access_key_selector: String.t,
    create_date: String.t,
    secret_access_key: String.t,
    status: String.t,
    username: String.t
  }
end
