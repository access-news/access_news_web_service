defmodule TR2Web.Repo do
  use Ecto.Repo,
    otp_app: :tr2_web,
    adapter: Ecto.Adapters.Postgres
end
