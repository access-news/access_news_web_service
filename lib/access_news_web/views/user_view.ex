defmodule AccessNewsWeb.UserView do
  use AccessNewsWeb, :view

  alias AccessNews.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
