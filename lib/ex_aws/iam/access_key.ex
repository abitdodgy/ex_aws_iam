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

  defstruct access_key_id: nil,
            access_key_selector: nil,
            create_date: nil,
            secret_access_key: nil,
            status: nil,
            username: nil

  @type t :: %ExAws.Iam.AccessKey{
          access_key_id: String.t(),
          access_key_selector: String.t(),
          create_date: String.t(),
          secret_access_key: String.t(),
          status: String.t(),
          username: String.t()
        }

  def new(%{list_access_keys_result: %{access_key_metadata: access_keys}}) do
    Enum.map(access_keys, fn key ->
      access_key_to_struct(key)
    end)
  end

  def new(%{create_access_key_result: %{access_key: access_key}}) do
    access_key_to_struct(access_key)
  end

  defp access_key_to_struct(access_key) do
    %ExAws.Iam.AccessKey{
      access_key_id: access_key[:access_key_id],
      access_key_selector: access_key[:access_key_selector],
      create_date: access_key[:create_date],
      secret_access_key: access_key[:secret_access_key],
      status: access_key[:status],
      username: access_key[:username]
    }
  end
end
