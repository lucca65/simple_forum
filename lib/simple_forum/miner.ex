defmodule SimpleForum.Miner do
  @moduledoc """
  Responsible for finding new activity to send updates
  """

  alias SimpleForum.Thread
  alias SimpleForum.Mailer

  @doc """
  Stuff could be better here. It is simple for demonstration proposes
  """
  def main do
    Thread.created_today |> Enum.map(&updates_on/1)
  end

  def updates_on([]), do: {}
  def updates_on(thread) do
    root = thread |> Thread.root

    emails = root
    |> Thread.thread_tree
    |> threads_emails

    template = """
    Hi! you are participating on the following discussion:

    <b>#{root.title}</b>

    User #{thread.author_email} posted a reply:
    <h4>#{thread.title}</h4>

    Thank you!
    """

    # send template to all emails
    Enum.map(emails, &(send_mail(&1, template)))

    {emails, template}
  end

  def send_mail(email, body) do
    Mailer.User.notifications(email, body) |> Mailer.deliver
  end

  defp threads_emails(thread_tree) do
    thread_tree
    |> List.flatten
    |> Enum.map(&(&1.author_email))
    |> Enum.uniq
  end
end
