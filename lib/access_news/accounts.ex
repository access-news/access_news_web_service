defmodule AccessNews.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias AccessNews.Accounts.User
  alias AccessNews.Repo

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end
end
