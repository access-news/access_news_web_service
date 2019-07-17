defmodule AccessNews.Repo do
  use Ecto.Repo,
    otp_app: :access_news,
    adapter: Ecto.Adapters.Postgres
end
