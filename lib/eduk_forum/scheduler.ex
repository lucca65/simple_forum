defmodule SimpleForum.Scheduler do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # do the work

    # reschedule it
    {:noreply, state}
  end

  @doc """
  Process work every 24 hours
  """
  def schedule_work() do
    Process.send_after(self(), :work, 24 * 60 * 60 * 1000)
  end
end
