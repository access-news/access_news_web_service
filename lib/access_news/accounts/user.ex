defmodule AccessNews.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string

    # TODO: validation
    field :email, :string

    timestamps()
  end
end
