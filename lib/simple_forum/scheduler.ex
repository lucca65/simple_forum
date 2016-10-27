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
    "Running email worker" |> IO.puts
    SimpleForum.Miner.main
    "Done! Rescheduling. . ." |> IO.puts
    schedule_work()
    "Okay, we will check for more news on 24 hours"

    # reschedule it
    {:noreply, state}
  end

  @doc """
  Process work every 24 hours
  """
  def schedule_work() do
    Process.send_after(self(), :work, 24 * 60 * 60 * 1000) # 24 hours
    # Process.send_after(self(), :work, 30 * 1000) # 30 seconds
  end
end
