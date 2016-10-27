defmodule SimpleForum.Mailer.User do
  import Swoosh.Email

  def notifications(email \\ "julienlucca@gmail.com", body \\ "Testing", subject \\ "You got new updates")
  def notifications(email, body, subject) do
    new
    |> to(email) # you may use a tuple for name and email
    |> from({"Old Sysadmin", "seeyou@darkevilcorp.org"})
    |> subject(subject)
    |> html_body(body)
  end
end
