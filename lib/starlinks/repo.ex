defmodule Starlinks.Repo do
  use Ecto.Repo,
    otp_app: :starlinks,
    adapter: Ecto.Adapters.Postgres
end
