defmodule Mkoussaelixir do
  @moduledoc """
  Mkoussaelixir keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def measure_orders do
    :telemetry.execute(
      [:mkoussaelixir, :orders],
      %{total: Mkoussaelixir.Orders.count_orders()},
      %{}
    )
  end
end
