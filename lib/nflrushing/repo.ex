defmodule Nflrushing.Repo do
  use Ecto.Repo,
    otp_app: :nflrushing,
    adapter: Ecto.Adapters.Postgres
end
