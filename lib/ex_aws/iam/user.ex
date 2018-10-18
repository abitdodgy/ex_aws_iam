defmodule ExAws.Iam.User do
  @moduledoc """
  A struct that represents an IAM user.

  """

  @enforce_keys ~w[
    arn
    create_date
    username
    user_id
  ]a

  defstruct arn: nil, create_date: nil, path: "/", username: nil, user_id: nil

  @type t :: %ExAws.Iam.User{
    arn: String.t,
    create_date: String.t,
    path: String.t,
    user_id: String.t,
    username: String.t
  }
end
