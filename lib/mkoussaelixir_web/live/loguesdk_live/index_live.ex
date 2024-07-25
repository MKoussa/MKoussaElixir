defmodule MkoussaelixirWeb.LoguesdkLive.IndexLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h3><.link patch={~p"/loguesdk/effects/"}>Effects</.link></h3>
      <p>Precompiled file downloads and Github links to Logue-SDK Effects.</p>
      <h3><.link patch={~p"/loguesdk/oscillators/"}>Oscillators</.link></h3>
      <p>Coming Soon...</p>
      <h3><.link patch={~p"/loguesdk/resources/"}>Resources</.link></h3>
      <p>Helpful links for coding the Korg NTS-1 (and DSP in general).</p>
    </section>
    """
  end
end
