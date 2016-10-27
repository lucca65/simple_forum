defmodule SimpleForum.Repo do
  use Ecto.Repo, otp_app: :simple_forum
  use Kerosene, per_page: 10
end
