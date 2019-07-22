defmodule AccessNewsWeb.SessionController do
  use AccessNewsWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(
    conn,
    %{"session" => %{"email" => email, "password" => passwd}}
  ) do
    case AccessNews.Accounts.auth_by_email_and_passwd(email, passwd) do
      {:ok, user} ->
        conn
        |> AccessNewsWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> AccessNewsWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
