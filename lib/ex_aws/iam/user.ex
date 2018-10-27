defmodule ExAws.Iam.User do
  @moduledoc """
  A struct that represents an IAM user.

  """

  @enforce_keys ~w[
    arn
    create_date
    user_name
    user_id
  ]a

  defstruct arn: nil, create_date: nil, path: "/", user_name: nil, user_id: nil

  @type t :: %ExAws.Iam.User{
          arn: String.t(),
          create_date: String.t(),
          path: String.t(),
          user_id: String.t(),
          user_name: String.t()
        }

  @doc """
  Returns a struct representation of an IAM User.

  """
  def new(%{get_user_response: %{get_user_result: %{user: user}}}), do: to_struct(user)

  def new(%{create_user_response: %{create_user_result: %{user: user}}}), do: to_struct(user)

  def new(%{list_users_response: %{list_users_result: %{users: users}}}) do
    Enum.map(users, fn user ->
      to_struct(user)
    end)
  end

  defp to_struct(user) do
    %ExAws.Iam.User{
      arn: user[:arn],
      create_date: user[:create_date],
      path: user[:path],
      user_name: user[:user_name],
      user_id: user[:user_id]
    }
  end
end
