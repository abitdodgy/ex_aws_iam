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

  def new(%{get_user_result: %{user: user}}) do
    user_to_struct(user)
  end

  def new(%{create_user_result: %{user: user}}) do
    user_to_struct(user)
  end

  def new(%{list_users_result: %{users: users}}) do
    Enum.map(users, fn user ->
      user_to_struct(user)
    end)
  end

  defp user_to_struct(user) do
    %ExAws.Iam.User{
      arn: user[:arn],
      create_date: user[:create_date],
      path: user[:path],
      username: user[:username],
      user_id: user[:user_id]
    }    
  end
end
